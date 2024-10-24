abstract class HtmlState {}

class HtmlLoading extends HtmlState {}

class HtmlLoaded extends HtmlState {
  final String htmlContent;
  HtmlLoaded(this.htmlContent);
}

class HtmlError extends HtmlState {
  final String error;
  HtmlError(this.error);
}
