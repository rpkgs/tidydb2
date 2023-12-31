% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/R6_dbase.R
\name{dbase}
\alias{dbase}
\title{Database class for duckdb and sqlite}
\description{
Database class for duckdb and sqlite

Database class for duckdb and sqlite
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{db}}{a character string specifying a database name.}

\item{\code{table}}{a character string specifying a table name.}

\item{\code{con}}{a database connection object.}

\item{\code{tbl}}{a \code{dplyr::tbl} object.}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-dbase-new}{\code{dbase$new()}}
\item \href{#method-dbase-print}{\code{dbase$print()}}
\item \href{#method-dbase-open_db}{\code{dbase$open_db()}}
\item \href{#method-dbase-open_table}{\code{dbase$open_table()}}
\item \href{#method-dbase-finalize}{\code{dbase$finalize()}}
\item \href{#method-dbase-close}{\code{dbase$close()}}
\item \href{#method-dbase-read_tables}{\code{dbase$read_tables()}}
\item \href{#method-dbase-read_table}{\code{dbase$read_table()}}
\item \href{#method-dbase-read_data}{\code{dbase$read_data()}}
\item \href{#method-dbase-write_table}{\code{dbase$write_table()}}
\item \href{#method-dbase-write_tables}{\code{dbase$write_tables()}}
\item \href{#method-dbase-clone}{\code{dbase$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dbase-new"></a>}}
\if{latex}{\out{\hypertarget{method-dbase-new}{}}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{dbase$new(db = NULL, table = NULL, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{db}}{a character string specifying a database name.}

\item{\code{table}}{a character string specifying a table name.}

\item{\code{...}}{ignored}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
NULL
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dbase-print"></a>}}
\if{latex}{\out{\hypertarget{method-dbase-print}{}}}
\subsection{Method \code{print()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{dbase$print(...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{ignored}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
NULL
create a db if not exits
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dbase-open_db"></a>}}
\if{latex}{\out{\hypertarget{method-dbase-open_db}{}}}
\subsection{Method \code{open_db()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{dbase$open_db(db = NULL, table = NULL, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{db}}{a character string specifying a database name.}

\item{\code{table}}{a character string specifying a table name.}

\item{\code{...}}{others to be passed to \code{duckdb::duckdb} or \code{RSQLite::SQLite}, or \code{dbConnect}}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dbase-open_table"></a>}}
\if{latex}{\out{\hypertarget{method-dbase-open_table}{}}}
\subsection{Method \code{open_table()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{dbase$open_table(table = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{table}}{a character string specifying a table name.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
NULL
close db
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dbase-finalize"></a>}}
\if{latex}{\out{\hypertarget{method-dbase-finalize}{}}}
\subsection{Method \code{finalize()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{dbase$finalize()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
NULL
close db
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dbase-close"></a>}}
\if{latex}{\out{\hypertarget{method-dbase-close}{}}}
\subsection{Method \code{close()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{dbase$close()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
NULL
Read Tables
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dbase-read_tables"></a>}}
\if{latex}{\out{\hypertarget{method-dbase-read_tables}{}}}
\subsection{Method \code{read_tables()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{dbase$read_tables(tables = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{tables}}{a character vector specifying table names.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
list of \code{dataframe}
Read Table
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dbase-read_table"></a>}}
\if{latex}{\out{\hypertarget{method-dbase-read_table}{}}}
\subsection{Method \code{read_table()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{dbase$read_table(table = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{table}}{a character string specifying a table name.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
\code{dataframe}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dbase-read_data"></a>}}
\if{latex}{\out{\hypertarget{method-dbase-read_data}{}}}
\subsection{Method \code{read_data()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{dbase$read_data(..., verbose = TRUE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{\code{dplyr::filter} expressions}

\item{\code{verbose}}{a logical specifying whether to print the time or not.
Write Table}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dbase-write_table"></a>}}
\if{latex}{\out{\hypertarget{method-dbase-write_table}{}}}
\subsection{Method \code{write_table()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{dbase$write_table(value, name = NULL, overwrite = TRUE, append = FALSE, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{value}}{\code{data.frame}}

\item{\code{name}}{a character string specifying a table name. SQLite table names
are not case sensitive, e.g., table names ABC and abc are considered equal.}

\item{\code{overwrite}}{a logical specifying whether to overwrite an existing table or not. Its default is FALSE.}

\item{\code{append}}{a logical specifying whether to append to an existing table in the DBMS. Its default is FALSE.}

\item{\code{...}}{others to be passed to \code{dbWriteTable}
Write Tables}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dbase-write_tables"></a>}}
\if{latex}{\out{\hypertarget{method-dbase-write_tables}{}}}
\subsection{Method \code{write_tables()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{dbase$write_tables(values, names = NULL, overwrite = TRUE, append = FALSE, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{values}}{a list of \code{data.frame}}

\item{\code{names}}{a character vector specifying table names.}

\item{\code{overwrite}}{a logical specifying whether to overwrite an existing table or not. Its default is FALSE.}

\item{\code{append}}{a logical specifying whether to append to an existing table in the DBMS. Its default is FALSE.}

\item{\code{...}}{others to be passed to \code{dbWriteTable}}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-dbase-clone"></a>}}
\if{latex}{\out{\hypertarget{method-dbase-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{dbase$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
