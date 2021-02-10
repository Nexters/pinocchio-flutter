import 'package:equatable/equatable.dart';

abstract class PhotoAnalysisEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoAnalysisInitialized extends PhotoAnalysisEvent {
  final String eventId;

  PhotoAnalysisInitialized(this.eventId);

  @override
  List<Object> get props => [eventId];
}
