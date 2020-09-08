module Plutus
  # The Account class represents accounts in the system. Each account must be subclassed as one of the following types:
  #
  #   TYPE        | NORMAL BALANCE    | DESCRIPTION
  #   --------------------------------------------------------------------------
  #   Asset       | Debit             | Resources owned by the Business Entity
  #   Liability   | Credit            | Debts owed to outsiders
  #   Equity      | Credit            | Owners rights to the Assets
  #   Revenue     | Credit            | Increases in owners equity
  #   Expense     | Debit             | Assets or services consumed in the generation of revenue
  #
  # Each account can also be marked as a "Contra Account". A contra account will have it's
  # normal balance swapped. For example, to remove equity, a "Drawing" account may be created
  # as a contra equity account as follows:
  #
  #   Plutus::Equity.create(:name => "Drawing", contra => true)
  #
  # At all times the balance of all accounts should conform to the "accounting equation"
  #   Plutus::Assets = Liabilties + Owner's Equity
  #
  # Each sublclass account acts as it's own ledger. See the individual subclasses for a
  # description.
  #
  # @abstract
  #   An account must be a subclass to be saved to the database. The Account class
  #   has a singleton method {trial_balance} to calculate the balance on all Accounts.
  #
  # @see http://en.wikipedia.org/wiki/Accounting_equation Accounting Equation
  # @see http://en.wikipedia.org/wiki/Debits_and_credits Debits, Credits, and Contra Accounts
  #
  # @author Michael Bulat
  class Account < ActiveRecord::Base

    if Plutus.enable_tenancy
      include Plutus::Tenancy
    else
      include Plutus::NoTenancy
    end

    class_attribute :normal_credit_balance

    has_many :amounts
    has_many :credit_amounts, extend: AmountsExtension, class_name: 'Plutus::CreditAmount'
    has_many :debit_amounts, extend: AmountsExtension, class_name: 'Plutus::DebitAmount'
    has_many :entries, through: :amounts, source: :entry
    has_many :credit_entries, through: :credit_amounts, source: :entry, class_name: 'Plutus::Entry'
    has_many :debit_entries, through: :debit_amounts, source: :entry, class_name: 'Plutus::Entry'

    validates :type, :name, presence: true
    validates :rollup_code, presence: true, numericality: { greater_than_or_equal_to: 100 }
    validates :code, presence: true, numericality: { greater_than_or_equal_to: 100 }
    validates :code, numericality: { greater_than_or_equal_to: :rollup_code,
                                     message: 'must be greater than or equal to Rollup Code.' }

    # The balance of the account. This instance method is intended for use only
    # on instances of account subclasses.
    #
    # If the account has a normal credit balance, the debits are subtracted from the credits
    # unless this is a contra account, in which case credits are substracted from debits.
    #
    # For a normal debit balance, the credits are subtracted from the debits
    # unless this is a contra account, in which case debits are subtracted from credits.
    #
    # Takes an optional hash specifying :from_date and :to_date for calculating balances during periods.
    # :from_date and :to_date may be strings of the form "yyyy-mm-dd" or Ruby Date objects
    #
    # @example
    #   >> liability.balance({:from_date => "2000-01-01", :to_date => Date.today})
    #   => #<BigDecimal:103259bb8,'0.1E4',4(12)>
    #
    # @example
    #   >> liability.balance
    #   => #<BigDecimal:103259bb8,'0.2E4',4(12)>
    #
    # @return [BigDecimal] The decimal value balance
    def balance(options = {})
      raise(NoMethodError, "undefined method 'balance'") unless self.class == Plutus::Account
      raise(NoMethodError, "can't run 'balance' on a rollup account - run rollup_balance") if rollup_account?

      if normal_credit_balance ^ contra
        credits_balance(options) - debits_balance(options)
      else
        debits_balance(options) - credits_balance(options)
      end
    end

    # The balance of the rollup account. The Rollup Account don't have its own balance.
    # It is calculated by the sum of the other accounts associated by the Rollup Code.
    # This instance method is intended for use only on instances of account that are rollup accounts.
    #
    # If the account has a normal credit balance, the debits are subtracted from the credits
    # unless this is a contra account, in which case credits are substracted from debits.
    #
    # For a normal debit balance, the credits are subtracted from the debits
    # unless this is a contra account, in which case debits are subtracted from credits.
    #
    # Takes an optional hash specifying :from_date and :to_date for calculating balances during periods.
    # :from_date and :to_date may be strings of the form "yyyy-mm-dd" or Ruby Date objects
    #
    # @example
    #   >> account.rollup_balance({:from_date => "2000-01-01", :to_date => Date.today})
    #   => #<BigDecimal:103259bb8,'0.1E4',4(12)>
    #
    # @example
    #   >> account.rollup_balance
    #   => #<BigDecimal:103259bb8,'0.2E4',4(12)>
    #
    # @return [Class::BigDecimal] The decimal value balance
    def rollup_balance(options = {})
      raise(NoMethodError, "can't run 'rollup_balance' on a normal account - run 'balance'") unless rollup_account?

      account_balance = BigDecimal('0')
      child_accounts.each do |account|
        if account.contra
          account_balance -= account.balance(options)
        else
          account_balance += account.balance(options)
        end
      end
      account_balance
    end

    # This method implements a method to get all child accounts when a master account is required for balance
    #
    # @return [ActiveRecord::Relation] A relation object of the child accounts for the rollup account
    def child_accounts
      raise StandardError, 'the account is NOT a rollup account' unless rollup_account?

      self.class.name.constantize.where('rollup_code == ?, code != ?', rollup_code, code)
    end

    # This method checks if the account is a rollup_account
    # @return [Boolean]
    def rollup_account?
      rollup_code == code
    end

    # The credit balance for the account.
    #
    # Takes an optional hash specifying :from_date and :to_date for calculating balances during periods.
    # :from_date and :to_date may be strings of the form "yyyy-mm-dd" or Ruby Date objects
    #
    # @example
    #   >> asset.credits_balance({:from_date => "2000-01-01", :to_date => Date.today})
    #   => #<BigDecimal:103259bb8,'0.1E4',4(12)>
    #
    # @example
    #   >> asset.credits_balance
    #   => #<BigDecimal:103259bb8,'0.1E4',4(12)>
    #
    # @return [BigDecimal] The decimal value credit balance
    def credits_balance(options = {})
      credit_amounts.balance(options)
    end

    # The debit balance for the account.
    #
    # Takes an optional hash specifying :from_date and :to_date for calculating balances during periods.
    # :from_date and :to_date may be strings of the form "yyyy-mm-dd" or Ruby Date objects
    #
    # @example
    #   >> asset.debits_balance({:from_date => "2000-01-01", :to_date => Date.today})
    #   => #<BigDecimal:103259bb8,'0.1E4',4(12)>
    #
    # @example
    #   >> asset.debits_balance
    #   => #<BigDecimal:103259bb8,'0.3E4',4(12)>
    #
    # @return [BigDecimal] The decimal value credit balance
    def debits_balance(options = {})
      debit_amounts.balance(options)
    end

    # This class method is used to return the balance of all accounts
    # for a given class and is intended for use only on account subclasses.
    #
    # Contra accounts are automatically subtracted from the balance.
    #
    # Takes an optional hash specifying :from_date and :to_date for calculating balances during periods.
    # :from_date and :to_date may be strings of the form "yyyy-mm-dd" or Ruby Date objects
    #
    # @example
    #   >> Plutus::Liability.balance({:from_date => "2000-01-01", :to_date => Date.today})
    #   => #<BigDecimal:103259bb8,'0.1E4',4(12)>
    #
    # @example
    #   >> Plutus::Liability.balance
    #   => #<BigDecimal:1030fcc98,'0.82875E5',8(20)>
    #
    # @return [BigDecimal] The decimal value balance
    def self.balance(options = {})
      raise(NoMethodError, "undefined method 'balance'") if new.class == Plutus::Account

      accounts_balance = BigDecimal('0')
      all.each do |account|
        if account.contra
          accounts_balance -= account.balance(options)
        else
          accounts_balance += account.balance(options)
        end
      end
      accounts_balance
    end

    # The trial balance of all accounts in the system. This should always equal zero,
    # otherwise there is an error in the system.
    #
    # @example
    #   >> Account.trial_balance.to_i
    #   => 0
    #
    # @return [BigDecimal] The decimal value balance of all accounts
    def self.trial_balance
      raise(NoMethodError, "undefined method 'trial_balance'") if new.class == Plutus::Account

      Plutus::Asset.balance - (Plutus::Liability.balance + Plutus::Equity.balance + Plutus::Revenue.balance - Plutus::Expense.balance)
    end
  end
end
