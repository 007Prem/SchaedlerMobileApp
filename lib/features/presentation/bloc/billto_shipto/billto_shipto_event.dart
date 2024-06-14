part of 'billto_shipto_bloc.dart';

abstract class BillToShipToEvent {}

class BillToShipToLoadEvent extends BillToShipToEvent {}

class BillToUpdateEvent extends BillToShipToEvent {
  final BillTo? billToAddress;

  BillToUpdateEvent(this.billToAddress);
}

class ShipToUpdateEvent extends BillToShipToEvent {
  final ShipTo? shipToAddress;

  ShipToUpdateEvent(this.shipToAddress);
}

class RecipientUpdateEvent extends BillToShipToEvent {
  final ShipTo? recipientAddress;

  RecipientUpdateEvent(this.recipientAddress);
}

class PickUpUpdateEvent extends BillToShipToEvent {
  final Warehouse? warehouse;

  PickUpUpdateEvent(this.warehouse);
}
