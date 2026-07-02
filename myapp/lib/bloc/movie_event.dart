import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

/// Dipanggil pas pertama kali page dibuka
class FetchMovies extends MovieEvent {
  const FetchMovies();
}

/// Dipanggil pas user pull-to-refresh
class RefreshMovies extends MovieEvent {
  const RefreshMovies();
}
