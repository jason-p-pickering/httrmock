% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/context.R
\name{with_httrmock_context}
\alias{with_httrmock_context}
\title{Perform \code{httrmock} request matching in a special context}
\usage{
with_httrmock_context(context, expr)
}
\arguments{
\item{context}{A string scalar, the name of the context.}

\item{expr}{An R expression to evaluate in the \code{httrmock} context.}
}
\value{
The value of \code{expr}.
}
\description{
A request only matches a recorded request, if
\itemize{
\item their HTTP method match,
\item their URIs match, and
\item their context match.
}
}
\details{
You can (and need to, currently) create a context every time you are
requesting the same URL multiple times, and you expect different
responses, for example because you used difference HTTP headers.

There is also a \emph{default} context, this is used for expressions
outside of \code{with_httrmock_context} calls.
}
\examples{

## REcord to a temporary file
Sys.setenv("HTTRMOCK_STORE" = tempfile())

## Record a response, in the default context
start_recording()
stop_replaying()
resp1 <- httr::GET("https://httpbin.org/headers")

## Use the same URL again, in a different context, so the previously
## recorded response is not replayed, and we get a different response.
start_replaying()
start_recording()
resp2 <- with_httrmock_context(
  "foobar",
  httr::GET(
    "https://httpbin.org/headers",
    httr::add_headers("X-Foobar" = "really")
  )
)

jsonlite::fromJSON(httr::content(resp1, as = "text"))$headers
jsonlite::fromJSON(httr::content(resp2, as = "text"))$headers
}
\seealso{
Other HTTP mocking: \code{\link{clear_recordings}},
  \code{\link{httrmock}}, \code{\link{list_recordings}},
  \code{\link{mocking_status}},
  \code{\link{stop_recording}}
}

