import 'package:equatable/equatable.dart';

abstract class PhotoAnalysisFinalResultEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoAnalysisFinalResultInitialized
    extends PhotoAnalysisFinalResultEvent {
  final String eventId;

  PhotoAnalysisFinalResultInitialized(this.eventId);

  @override
  List<Object> get props => [eventId];
}
