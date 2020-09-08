# this seed file must be copied to your app to perform basic account creation
# Account Creation for ARGENTINA
# ONLY GLOBAL ACCOUNTS
# Code sequence: 10000 - Activo 11000 Activo Corriente 11100 Activo corriente Global 1 11101
#
#
#
# Fetch ACTIVO => Plutus::Asset.all
# Fetch ACTIVO CORRIENTE => Plutus::Asset.where(rollup_code: 11000)
# Fetch RUBRO Caja y Bancos => Plutus::Asset.where(rollup_code: 11100)

# ASSETS ACCOUNTS (ACTIVO)
Plutus::Asset.create(code: 11000, rollup_code: 11000, name: 'ACTIVO CORRIENTE')
  Plutus::Asset.create(code: 11100, rollup_code: 11100, name: 'CAJA Y BANCOS')
    Plutus::Asset.create(code: 11101, rollup_code: 11100, name: 'CAJA EFECTIVO $ARS')
    Plutus::Asset.create(code: 11102, rollup_code: 11100, name: 'CAJA EFECTIVO $USD')
    Plutus::Asset.create(code: 11103, rollup_code: 11100, name: 'VALORES A DEPOSITAR')
    Plutus::Asset.create(code: 11104, rollup_code: 11100, name: 'C.C BANCO PATAGONIA $ARS')
    Plutus::Asset.create(code: 11105, rollup_code: 11100, name: 'C.C BANCO GALICIA $ARS')
    Plutus::Asset.create(code: 11106, rollup_code: 11100, name: 'C.C BANCO NACION $ARS')
    Plutus::Asset.create(code: 11107, rollup_code: 11100, name: 'CHEQUES RECHAZADOS')
  Plutus::Asset.create(code: 11200, rollup_code: 11200, name: 'CREDITOS POR VENTAS')
  Plutus::Asset.create(code: 11300, rollup_code: 11300, name: 'OTROS CREDITOS')
    Plutus::Asset.create(code: 11301, rollup_code: 113, name: 'IVA - CREDITO FISCAL')
    Plutus::Asset.create(code: 11302, rollup_code: 113, name: 'IVA - SALDO A FAVOR')
    Plutus::Asset.create(code: 11303, rollup_code: 113, name: 'IIGG - ANTICIPOS')
    Plutus::Asset.create(code: 11304, rollup_code: 113, name: 'IIGG - SALDO A FAVOR')
    Plutus::Asset.create(code: 11305, rollup_code: 113, name: 'IIBB - SALDO A FAVOR - CABA')
    Plutus::Asset.create(code: 11307, rollup_code: 113, name: 'IIBB - SALDO A FAVOR - BSAS')
    Plutus::Asset.create(code: 11307, rollup_code: 113, name: 'ANTICIPOS DE SUELDO - OTORGADOS')
    Plutus::Asset.create(code: 11308, rollup_code: 113, name: 'IIBB - PERCEPCIONES - CABA')
    Plutus::Asset.create(code: 11309, rollup_code: 113, name: 'IIBB - PERCEPCIONES - BSAS')
    Plutus::Asset.create(code: 11310, rollup_code: 113, name: 'IVA - PERCEPCIONES')
    Plutus::Asset.create(code: 11311, rollup_code: 113, name: 'IVA - RETENCIONES')
  Plutus::Asset.create(code: 11400, rollup_code: 11400, name: 'BIENES DE CAMBIO')
  Plutus::Asset.create(code: 11500, rollup_code: 11500, name: 'INVERSIONES CORRIENTES')
Plutus::Asset.create(code: 12000, rollup_code: 11000, name: 'ACTIVO NO CORRIENTE')
  Plutus::Asset.create(code: 12100, rollup_code: 12100, name: 'INVERSIONES NO CORRIENTES')
  Plutus::Asset.create(code: 12200, rollup_code: 12200, name: 'BIENES DE USO')
  Plutus::Asset.create(code: 12300, rollup_code: 12300, name: 'BIENES INMATERIALES')
  Plutus::Asset.create(code: 12400, rollup_code: 12400, name: 'OTROS CREDITOS')

# LIABILITY ACCOUNTS (PASIVO)
Plutus::Asset.create(code: 21000, rollup_code: 21000, name: 'PASIVO CORRIENTE')
  Plutus::Liability.create(code: 21100, rollup_code: 21000, name: 'DEUDAS BANCARIAS Y FINANCIERAS')
    Plutus::Liability.create(code: 21101, rollup_code: 21100, name: 'PRESTAMOS BANCARIOS')
    Plutus::Liability.create(code: 21102, rollup_code: 21100, name: 'ADELANTOS EN C/C')
    Plutus::Liability.create(code: 21103, rollup_code: 21100, name: 'OTRAS DEUDAS BANCARIAS')
  Plutus::Liability.create(code: 21200, rollup_code: 21200, name: 'DEUDAS COMERCIALES')
    Plutus::Liability.create(code: 21201, rollup_code: 21200, name: 'PROVEEDORES')
    Plutus::Liability.create(code: 21202, rollup_code: 21200, name: 'ANTICIPOS DE CLIENTES')
    Plutus::Liability.create(code: 21204, rollup_code: 21200, name: 'ACREEDORES VARIOS')
    Plutus::Liability.create(code: 21205, rollup_code: 21200, name: 'GASTOS DE VENTA - A PAGAR')
    Plutus::Liability.create(code: 21206, rollup_code: 21200, name: 'TARJETAS DE CREDITO - A PAGAR')
    Plutus::Liability.create(code: 21207, rollup_code: 21200, name: 'OTRAS DEUDAS COMECIALES')
  Plutus::Liability.create(code: 21300, rollup_code: 21300, name: 'DEUDAS SOCIALES - CORRIENTES')
    Plutus::Liability.create(code: 21301, rollup_code: 21300, name: 'SUELDOS - A PAGAR')
    Plutus::Liability.create(code: 21302, rollup_code: 21300, name: 'CARGAS SOCIALES - A PAGAR')
    Plutus::Liability.create(code: 21303, rollup_code: 21300, name: 'CARGAS SOCIALES - A PAGAR')
  Plutus::Liability.create(code: 21400, rollup_code: 21400, name: 'DEUDAS FISCALES')
    Plutus::Liability.create(code: 21401, rollup_code: 21400, name: 'IVA - A PAGAR')
    Plutus::Liability.create(code: 21402, rollup_code: 21400, name: 'IIBB - A PAGAR')
    Plutus::Liability.create(code: 21403, rollup_code: 21400, name: 'IIGG - A PAGAR')
    Plutus::Liability.create(code: 21404, rollup_code: 21400, name: 'PLANES DE PAGO AFIP - A PAGAR')
    Plutus::Liability.create(code: 21406, rollup_code: 21400, name: 'OTROS IMPUESTOS - A PAGAR')
    Plutus::Liability.create(code: 21407, rollup_code: 21400, name: 'IVA - DEBITO FISCAL')
Plutus::Asset.create(code: 22000, rollup_code: 22000, name: 'PASIVO NO CORRIENTE')
  Plutus::Liability.create(code: 22100, rollup_code: 22000, name: 'DEUDAS BANCARIAS Y FINANCIERAS - NO CORRIENTES')
  Plutus::Liability.create(code: 22200, rollup_code: 22000, name: 'DEUDAS SOCIALES - NO CORRIENTES')
  Plutus::Liability.create(code: 22300, rollup_code: 22000, name: 'DEUDAS FISCALES - NO CORRIENTES')
  Plutus::Liability.create(code: 22400, rollup_code: 22000, name: 'OTRAS DEUDAS - NO CORRIENTES')


# CAPITAL ACCOUNTS (PN)
Plutus::Equity.create(code: 311, rollup_code: 311, name: 'CAPITAL SOCIAL / ACCIONES')
  Plutus::Equity.create(code: 31101, rollup_code: 311, name: 'CAPITAL SOCIAL / ACCIONES')
  Plutus::Equity.create(code: 31102, rollup_code: 311, name: 'AJUSTE DE CAPITAL')
  Plutus::Equity.create(code: 31103, rollup_code: 311, name: 'GARANTIA SOCIOS')
  Plutus::Equity.create(code: 31104, rollup_code: 311, name: 'APORTES INREVOCABLES')
  Plutus::Equity.create(code: 31105, rollup_code: 311, name: 'CAPITAL')
Plutus::Equity.create(code: 312, rollup_code: 312, name: 'RESERVAS')
  Plutus::Equity.create(code: 31201, rollup_code: 312, name: 'RESERVA LEGAL')
  Plutus::Equity.create(code: 31202, rollup_code: 312, name: 'RESERVAS VOLUNTARIAS')
  Plutus::Equity.create(code: 31203, rollup_code: 312, name: 'OTRAS RESERVAS')
Plutus::Equity.create(code: 313, rollup_code: 313, name: 'RESULTADOS ACUMULADOS')
  Plutus::Equity.create(code: 31301, rollup_code: 313, name: 'RESULTADOS DE EJ. ANTERIORES - NO ASIGNADOS')
  Plutus::Equity.create(code: 31302, rollup_code: 313, name: 'RESULTADOS DEL EJERCICIO')

# REVENUE ACCOUNTS (RESULTADOS POSITIVOS)
Plutus::Revenue.create(code: 411, rollup_code: 411, name: 'RESULTADOS POR VENTAS')
  Plutus::Revenue.create(code: 41101, rollup_code: 411, name: 'INGRESOS POR ABONOS MENSUALES')
  Plutus::Revenue.create(code: 41102, rollup_code: 411, name: 'INGRESOS POR REPARACIONES')
Plutus::Revenue.create(code: 412, rollup_code: 412, name: 'OTROS INGRESOS')
  Plutus::Revenue.create(code: 41201, rollup_code: 412, name: 'INTERESES GANADOS')
  Plutus::Revenue.create(code: 41202, rollup_code: 412, name: 'RESULTADOS POR VENTA BIENES DE USO')
  Plutus::Revenue.create(code: 41203, rollup_code: 412, name: 'DESCUENTOS OBTENIDOS')
  Plutus::Revenue.create(code: 41204, rollup_code: 412, name: 'OTROS INGRESOS')

# EXPENSE ACCOUNTS (RESULTADOS NEGATIVOS)
Plutus::Expense.create(code: 511, rollup_code: 511, name: 'EGRESOS / GASTOS')
  Plutus::Expense.create(code: 51101, rollup_code: 511, name: 'COSTO DE SERVICIOS PRESTADOS')
  Plutus::Expense.create(code: 51102, rollup_code: 511, name: 'GASTOS DE VENTA')
  Plutus::Expense.create(code: 51103, rollup_code: 511, name: 'GASTOS DE COMERCIALIZACION')
  Plutus::Expense.create(code: 51104, rollup_code: 511, name: 'GASTOS DE ADMINISTRACION')
  Plutus::Expense.create(code: 51105, rollup_code: 511, name: 'GASTOS DE REPRESENTACION')
  Plutus::Expense.create(code: 51106, rollup_code: 511, name: 'GASTOS NO DEDUCIBLES')
  Plutus::Expense.create(code: 51107, rollup_code: 511, name: 'AMORTIZACIONES DEL EJ.')
  Plutus::Expense.create(code: 51108, rollup_code: 511, name: 'CONTRIBUCIONES DE SEGURIDAD SOCIAL')


































