enum AcquirerEnum {
  vero("vero"),
  stone("stone"),
  cielo("cielo"),
  pagseguro("pagseguro"),
  rede("rede"),
  caixa("caixa"),
  bin("bin"),
  sicredi("sicredi");

  final String acquirer;
  const AcquirerEnum(this.acquirer);
}

enum DevicesAcceptedByVero {
  GPOS700("GPOS700"),
  P2_B("P2-B"),
  L3("L3");

  final String device;
  const DevicesAcceptedByVero(this.device);
}