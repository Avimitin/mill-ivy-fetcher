# SQLite JDBC 3.46.1.0 API Reference
Generated from Maven Central `*-sources.jar` artifacts for the dependency selected in `build.mill`. Adjacent upstream Scaladoc/Javadoc comments are copied when present; implementation bodies are intentionally omitted.

Summary: extracted `1441` non-private declaration signatures from `56` source files.

## Coordinates
- Direct dependency: `org.xerial:sqlite-jdbc:3.46.1.0`
- Upstream docs: https://github.com/xerial/sqlite-jdbc
- Source artifacts included:
  - `org.xerial:sqlite-jdbc:3.46.1.0`

## Common imports

```scala
import org.sqlite.SQLiteDataSource
```

## Usage notes

Xerial SQLite JDBC driver and data source classes. This project primarily uses `org.sqlite.SQLiteDataSource` to create a JDBC data source for ScalaSql.

```scala
val dataSource = new org.sqlite.SQLiteDataSource()
dataSource.setUrl("jdbc:sqlite:/tmp/repository.sqlite")
dataSource.setBusyTimeout(5000)

val connection = dataSource.getConnection()
try
  val statement = connection.createStatement()
  try statement.executeUpdate("PRAGMA foreign_keys = ON")
  finally statement.close()
finally connection.close()
```

## API signatures from upstream source

### `org.xerial:sqlite-jdbc:3.46.1.0`

Source: https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.46.1.0/sqlite-jdbc-3.46.1.0-sources.jar

#### `org/sqlite/BusyHandler.java`

> https://www.sqlite.org/c3ref/busy_handler.html

```java
public abstract class BusyHandler
```

> Sets a busy handler for the connection.
>
> @param conn the SQLite connection
> @param busyHandler the busyHandler
> @throws SQLException

```java
public static final void setHandler(Connection conn, BusyHandler busyHandler)
```

> Clears any busy handler registered with the connection.
>
> @param conn the SQLite connection
> @throws SQLException

```java
public static final void clearHandler(Connection conn) throws SQLException
```

#### `org/sqlite/Collation.java`

> Provides an interface for creating SQLite user-defined collations.
>
> <p>A subclass of <tt>org.sqlite.Collation</tt> can be registered with <tt>Collation.create()</tt>
> and called by the name it was given. All collations must implement <tt>xCompare(String,
> String)</tt>, which is called when SQLite compares two strings using the custom collation. Eg.
>
> <pre>
> Class.forName("org.sqlite.JDBC");
> Connection conn = DriverManager.getConnection("jdbc:sqlite:");
>
> Collation.create(conn, "REVERSE", new Collation() {
> protected int xCompare(String str1, String str2) {
> return str1.compareTo(str2) * -1;
> }
> });
>
> conn.createStatement().execute("select c1 from t order by c1 collate REVERSE;");
> </pre>

```java
public abstract class Collation
```

> Registers a given collation with the connection.
>
> @param conn The connection.
> @param name The name of the collation.
> @param f The collation to register.

```java
public static final void create(Connection conn, String name, Collation f) throws SQLException
```

> Removes a named collation from the given connection.
>
> @param conn The connection to remove the collation from.
> @param name The name of the collation.
> @throws SQLException

```java
public static final void destroy(Connection conn, String name) throws SQLException
```

#### `org/sqlite/ExtendedCommand.java`

> parsing SQLite specific extension of SQL command
>
> @author leo

```java
public class ExtendedCommand
```

```java
public static interface SQLExtension
```

```java
public void execute(DB db) throws SQLException ;
```

> Parses extended commands of "backup" or "restore" for SQLite database.
>
> @param sql One of the extended commands:<br>
> backup sourceDatabaseName to destinationFileName OR restore targetDatabaseName from
> sourceFileName
> @return BackupCommand object if the argument is a backup command; RestoreCommand object if
> the argument is a restore command;
> @throws SQLException

```java
public static SQLExtension parse(String sql) throws SQLException
```

> Remove the quotation mark from string.
>
> @param s String with quotation mark.
> @return String with quotation mark removed.

```java
public static String removeQuotation(String s)
```

```java
public static class BackupCommand implements SQLExtension
```

```java
public final String srcDB ;
```

```java
public final String destFile ;
```

> Parses SQLite database backup command and creates a BackupCommand object.
>
> @param sql SQLite database backup command.
> @return BackupCommand object.
> @throws SQLException

```java
public static BackupCommand parse(String sql) throws SQLException
```

```java
public void execute(DB db) throws SQLException
```

```java
public static class RestoreCommand implements SQLExtension
```

```java
public final String targetDB ;
```

```java
public final String srcFile ;
```

> Parses SQLite database restore command and creates a RestoreCommand object.
>
> @param sql SQLite restore backup command
> @return RestoreCommand object.
> @throws SQLException

```java
public static RestoreCommand parse(String sql) throws SQLException
```

> @see org.sqlite.ExtendedCommand.SQLExtension#execute(org.sqlite.core.DB)

```java
public void execute(DB db) throws SQLException
```

#### `org/sqlite/FileException.java`

```java
public class FileException extends Exception
```

#### `org/sqlite/Function.java`

> Provides an interface for creating SQLite user-defined functions.
>
> <p>A subclass of <tt>org.sqlite.Function</tt> can be registered with <tt>Function.create()</tt>
> and called by the name it was given. All functions must implement <tt>xFunc()</tt>, which is
> called when SQLite runs the custom function. E.g.
>
> <pre>
> Class.forName("org.sqlite.JDBC");
> Connection conn = DriverManager.getConnection("jdbc:sqlite:");
>
> Function.create(conn, "myFunc", new Function() {
> protected void xFunc() {
> System.out.println("myFunc called!");
> }
> });
>
> conn.createStatement().execute("select myFunc();");
> </pre>
>
> <p>Arguments passed to a custom function can be accessed using the <tt>protected</tt> functions
> provided. <tt>args()</tt> returns the number of arguments passed, while
> <tt>value_<type>(int)</tt> returns the value of the specific argument. Similarly, a
> function can return a value using the <tt>result(<type>)</tt> function.

```java
public abstract class Function
```

> Flag to provide to {@link #create(Connection, String, Function, int)} that marks this
> Function as deterministic, making is usable in Indexes on Expressions.

```java
public static final int FLAG_DETERMINISTIC = ...
```

> Registers a given function with the connection.
>
> @param conn The connection.
> @param name The name of the function.
> @param f The function to register.

```java
public static void create(Connection conn, String name, Function f) throws SQLException
```

> Registers a given function with the connection.
>
> @param conn The connection.
> @param name The name of the function.
> @param f The function to register.
> @param flags Extra flags to pass, such as {@link #FLAG_DETERMINISTIC}

```java
public static void create(Connection conn, String name, Function f, int flags)
```

> Registers a given function with the connection.
>
> @param conn The connection.
> @param name The name of the function.
> @param f The function to register.
> @param nArgs The number of arguments that the function takes.
> @param flags Extra flags to pass, such as {@link #FLAG_DETERMINISTIC}

```java
public static void create(Connection conn, String name, Function f, int nArgs, int flags)
```

> Removes a named function from the given connection.
>
> @param conn The connection to remove the function from.
> @param name The name of the function.
> @param nArgs Ignored.
> @throws SQLException

```java
public static void destroy(Connection conn, String name, int nArgs) throws SQLException
```

> Removes a named function from the given connection.
>
> @param conn The connection to remove the function from.
> @param name The name of the function.
> @throws SQLException

```java
public static void destroy(Connection conn, String name) throws SQLException
```

> Provides an interface for creating SQLite user-defined aggregate functions.
>
> @see Function

```java
public abstract static class Aggregate extends Function implements Cloneable
```

> @see java.lang.Object#clone()

```java
public Object clone() throws CloneNotSupportedException
```

> Provides an interface for creating SQLite user-defined window functions.
>
> @see Aggregate

```java
public abstract static class Window extends Aggregate
```

#### `org/sqlite/JDBC.java`

```java
public class JDBC implements Driver
```

```java
public static final String PREFIX = ...
```

> @see java.sql.Driver#getMajorVersion()

```java
public int getMajorVersion()
```

> @see java.sql.Driver#getMinorVersion()

```java
public int getMinorVersion()
```

> @see java.sql.Driver#jdbcCompliant()

```java
public boolean jdbcCompliant()
```

```java
public Logger getParentLogger() throws SQLFeatureNotSupportedException
```

> @see java.sql.Driver#acceptsURL(java.lang.String)

```java
public boolean acceptsURL(String url)
```

> Validates a URL
>
> @param url
> @return true if the URL is valid, false otherwise

```java
public static boolean isValidURL(String url)
```

> @see java.sql.Driver#getPropertyInfo(java.lang.String, java.util.Properties)

```java
public DriverPropertyInfo[] getPropertyInfo(String url, Properties info) throws SQLException
```

> @see java.sql.Driver#connect(java.lang.String, java.util.Properties)

```java
public Connection connect(String url, Properties info) throws SQLException
```

> Gets the location to the database from a given URL.
>
> @param url The URL to extract the location from.
> @return The location to the database.

```java
static String extractAddress(String url)
```

> Creates a new database connection to a given URL.
>
> @param url the URL
> @param prop the properties
> @return a Connection object that represents a connection to the URL
> @throws SQLException
> @see java.sql.Driver#connect(java.lang.String, java.util.Properties)

```java
public static SQLiteConnection createConnection(String url, Properties prop)
```

#### `org/sqlite/NativeLibraryNotFoundException.java`

```java
public class NativeLibraryNotFoundException extends Exception
```

#### `org/sqlite/ProgressHandler.java`

> https://www.sqlite.org/c3ref/progress_handler.html

```java
public abstract class ProgressHandler
```

> Sets a progress handler for the connection.
>
> @param conn the SQLite connection
> @param vmCalls the approximate number of virtual machine instructions that are evaluated
> between successive invocations of the progressHandler
> @param progressHandler the progressHandler
> @throws SQLException

```java
public static final void setHandler(
            Connection conn, int vmCalls, ProgressHandler progressHandler) throws SQLException
```

> Clears any progress handler registered with the connection.
>
> @param conn the SQLite connection
> @throws SQLException

```java
public static final void clearHandler(Connection conn) throws SQLException
```

#### `org/sqlite/SQLiteCommitListener.java`

> https://www.sqlite.org/c3ref/commit_hook.html

```java
public interface SQLiteCommitListener
```

#### `org/sqlite/SQLiteConfig.java`

> SQLite Configuration
>
> <p>See also https://www.sqlite.org/pragma.html
>
> @author leo

```java
public class SQLiteConfig
```

```java
public static final String DEFAULT_DATE_STRING_FORMAT = ...
```

```java
public SQLiteConnectionConfig newConnectionConfig()
```

> Create a new JDBC connection using the current configuration
>
> @return The connection.
> @throws SQLException

```java
public Connection createConnection(String url) throws SQLException
```

> Configures a connection.
>
> @param conn The connection to configure.
> @throws SQLException

```java
public void apply(Connection conn) throws SQLException
```

> Checks if the shared cache option is turned on.
>
> @return True if turned on; false otherwise.

```java
public boolean isEnabledSharedCache()
```

> Checks if the load extension option is turned on.
>
> @return True if turned on; false otherwise.

```java
public boolean isEnabledLoadExtension()
```

> @return The open mode flags.

```java
public int getOpenModeFlags()
```

> Sets a pragma's value.
>
> @param pragma The pragma to change.
> @param value The value to set it to.

```java
public void setPragma(Pragma pragma, String value)
```

> Convert this configuration into a Properties object, which can be passed to the {@link
> DriverManager#getConnection(String, Properties)}.
>
> @return The property object.

```java
public Properties toProperties()
```

> @return Array of DriverPropertyInfo objects.

```java
static DriverPropertyInfo[] getDriverPropertyInfo()
```

```java
static class OnOff
```

```java
static final Set<String> pragmaSet = ...
```

> @return true if explicit read only transactions are enabled

```java
public boolean isExplicitReadOnly()
```

> Enable read only transactions after connection creation if explicit read only is true.
>
> @param readOnly whether to enable explicit read only

```java
public void setExplicitReadOnly(boolean readOnly)
```

```java
public enum Pragma
```

```java
public final String pragmaName ;
```

```java
public final String[] choices ;
```

```java
public final String description ;
```

```java
public final String getPragmaName()
```

> Sets the open mode flags.
>
> @param mode The open mode.
> @see <a
> href="https://www.sqlite.org/c3ref/c_open_autoproxy.html">https://www.sqlite.org/c3ref/c_open_autoproxy.html</a>

```java
public void setOpenMode(SQLiteOpenMode mode)
```

> Re-sets the open mode flags.
>
> @param mode The open mode.
> @see <a
> href="https://www.sqlite.org/c3ref/c_open_autoproxy.html">https://www.sqlite.org/c3ref/c_open_autoproxy.html</a>

```java
public void resetOpenMode(SQLiteOpenMode mode)
```

> Enables or disables the sharing of the database cache and schema data structures between
> connections to the same database.
>
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/c3ref/enable_shared_cache.html">www.sqlite.org/c3ref/enable_shared_cache.html</a>

```java
public void setSharedCache(boolean enable)
```

> Enables or disables extension loading.
>
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/c3ref/load_extension.html">www.sqlite.org/c3ref/load_extension.html</a>

```java
public void enableLoadExtension(boolean enable)
```

> Sets the read-write mode for the database.
>
> @param readOnly True for read-only; otherwise read-write.

```java
public void setReadOnly(boolean readOnly)
```

> Changes the maximum number of database disk pages that SQLite will hold in memory at once per
> open database file.
>
> @param numberOfPages Cache size in number of pages.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_cache_size">www.sqlite.org/pragma.html#pragma_cache_size</a>

```java
public void setCacheSize(int numberOfPages)
```

> Enables or disables case sensitive for the LIKE operator.
>
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_case_sensitive_like">www.sqlite.org/pragma.html#pragma_case_sensitive_like</a>

```java
public void enableCaseSensitiveLike(boolean enable)
```

> @deprecated Enables or disables the count-changes flag. When enabled, INSERT, UPDATE and
> DELETE statements return the number of rows they modified.
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_count_changes">www.sqlite.org/pragma.html#pragma_count_changes</a>

```java
    @Deprecated
public void enableCountChanges(boolean enable)
```

> Sets the suggested maximum number of database disk pages that SQLite will hold in memory at
> once per open database file. The cache size set here persists across database connections.
>
> @param numberOfPages Cache size in number of pages.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_cache_size">www.sqlite.org/pragma.html#pragma_cache_size</a>

```java
public void setDefaultCacheSize(int numberOfPages)
```

> Defers enforcement of foreign key constraints until the outermost transaction is committed.
>
> @param enable True to enable; false to disable;
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_defer_foreign_keys">https://www.sqlite.org/pragma.html#pragma_defer_foreign_keys</a>

```java
public void deferForeignKeys(boolean enable)
```

> @deprecated Enables or disables the empty_result_callbacks flag.
> @param enable True to enable; false to disable. false.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_empty_result_callbacks">https://www.sqlite.org/pragma.html#pragma_empty_result_callbacks</a>

```java
    @Deprecated
public void enableEmptyResultCallBacks(boolean enable)
```

```java
public String getValue() ;
```

```java
public enum Encoding implements PragmaValue
```

```java
public final String typeName ;
```

```java
public String getValue()
```

```java
public static Encoding getEncoding(String value)
```

```java
public enum JournalMode implements PragmaValue
```

```java
public String getValue()
```

> Sets the text encoding used by the main database.
>
> @param encoding One of {@link Encoding}
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_encoding">www.sqlite.org/pragma.html#pragma_encoding</a>

```java
public void setEncoding(Encoding encoding)
```

> Whether to enforce foreign key constraints. This setting affects the execution of all
> statements prepared using the database connection, including those prepared before the
> setting was changed.
>
> @param enforce True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_foreign_keys">www.sqlite.org/pragma.html#pragma_foreign_keys</a>

```java
public void enforceForeignKeys(boolean enforce)
```

> @deprecated Enables or disables the full_column_name flag. This flag together with the
> short_column_names flag determine the way SQLite assigns names to result columns of
> SELECT statements.
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_full_column_names">www.sqlite.org/pragma.html#pragma_full_column_names</a>

```java
    @Deprecated
public void enableFullColumnNames(boolean enable)
```

> Enables or disables the fullfsync flag. This flag determines whether or not the F_FULLFSYNC
> syncing method is used on systems that support it. The default value of the fullfsync flag is
> off. Only Mac OS X supports F_FULLFSYNC.
>
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_fullfsync">www.sqlite.org/pragma.html#pragma_fullfsync</a>

```java
public void enableFullSync(boolean enable)
```

> Sets the incremental_vacuum value; the number of pages to be removed from the <a
> href="https://www.sqlite.org/fileformat2.html#freelist">freelist</a>. The database file is
> truncated by the same amount.
>
> @param numberOfPagesToBeRemoved The number of pages to be removed.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_incremental_vacuum">www.sqlite.org/pragma.html#pragma_incremental_vacuum</a>

```java
public void incrementalVacuum(int numberOfPagesToBeRemoved)
```

> Sets the journal mode for databases associated with the current database connection.
>
> @param mode One of {@link JournalMode}
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_journal_mode">www.sqlite.org/pragma.html#pragma_journal_mode</a>

```java
public void setJournalMode(JournalMode mode)
```

> Sets the journal_size_limit. This setting limits the size of the rollback-journal and WAL
> files left in the file-system after transactions or checkpoints.
>
> @param limit Limit value in bytes. A negative number implies no limit.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_journal_size_limit">www.sqlite.org/pragma.html#pragma_journal_size_limit</a>

```java
public void setJournalSizeLimit(int limit)
```

> Sets the value of the legacy_file_format flag. When this flag is enabled, new SQLite
> databases are created in a file format that is readable and writable by all versions of
> SQLite going back to 3.0.0. When the flag is off, new databases are created using the latest
> file format which might not be readable or writable by versions of SQLite prior to 3.3.0.
>
> @param use True to turn on legacy file format; false to turn off.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_legacy_file_format">www.sqlite.org/pragma.html#pragma_legacy_file_format</a>

```java
public void useLegacyFileFormat(boolean use)
```

> Sets the value of the legacy_alter_table flag. When this flag is on, the ALTER TABLE RENAME
> command (for changing the name of a table) works as it did in SQLite 3.24.0 (2018-06-04) and
> earlier.When the flag is off, using the ALTER TABLE RENAME command will mean that all
> references to the table anywhere in the schema will be converted to the new name.
>
> @param flag True to turn on legacy alter table behaviour; false to turn off.
> @see <a href="https://www.sqlite.org/pragma.html#pragma_legacy_alter_table</a>

```java
public void setLegacyAlterTable(boolean flag)
```

```java
public enum LockingMode implements PragmaValue
```

```java
public String getValue()
```

> Sets the database connection locking-mode.
>
> @param mode One of {@link LockingMode}
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_locking_mode">www.sqlite.org/pragma.html#pragma_locking_mode</a>

```java
public void setLockingMode(LockingMode mode)
```

> Sets the page size of the database. The page size must be a power of two between 512 and
> 65536 inclusive.
>
> @param numBytes A power of two between 512 and 65536 inclusive.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_page_size">www.sqlite.org/pragma.html#pragma_page_size</a>

```java
public void setPageSize(int numBytes)
```

> Sets the maximum number of pages in the database file.
>
> @param numPages Number of pages.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_max_page_count">www.sqlite.org/pragma.html#pragma_max_page_count</a>

```java
public void setMaxPageCount(int numPages)
```

> Enables or disables useReadUncommittedIsolationMode.
>
> @param useReadUncommittedIsolationMode True to turn on; false to disable. disabled otherwise.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_read_uncommitted">www.sqlite.org/pragma.html#pragma_read_uncommitted</a>

```java
public void setReadUncommitted(boolean useReadUncommittedIsolationMode)
```

> Enables or disables the recursive trigger capability.
>
> @param enable True to enable the recursive trigger capability.
> @see <a
> href="www.sqlite.org/pragma.html#pragma_recursive_triggers">www.sqlite.org/pragma.html#pragma_recursive_triggers</a>

```java
public void enableRecursiveTriggers(boolean enable)
```

> Enables or disables the reverse_unordered_selects flag. This setting causes SELECT statements
> without an ORDER BY clause to emit their results in the reverse order of what they normally
> would. This can help debug applications that are making invalid assumptions about the result
> order.
>
> @param enable True to enable reverse_unordered_selects.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_reverse_unordered_selects">www.sqlite.org/pragma.html#pragma_reverse_unordered_selects</a>

```java
public void enableReverseUnorderedSelects(boolean enable)
```

> Enables or disables the short_column_names flag. This flag affects the way SQLite names
> columns of data returned by SELECT statements.
>
> @param enable True to enable short_column_names.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_short_column_names">www.sqlite.org/pragma.html#pragma_short_column_names</a>

```java
public void enableShortColumnNames(boolean enable)
```

```java
public enum SynchronousMode implements PragmaValue
```

```java
public String getValue()
```

> Changes the setting of the "synchronous" flag.
>
> @param mode One of {@link SynchronousMode}:
> <ul>
> <li>OFF - SQLite continues without syncing as soon as it has handed data off to the
> operating system
> <li>NORMAL - the SQLite database engine will still sync at the most critical moments,
> but less often than in FULL mode
> <li>FULL - the SQLite database engine will use the xSync method of the VFS to ensure
> that all content is safely written to the disk surface prior to continuing. This
> ensures that an operating system crash or power failure will not corrupt the
> database.
> </ul>
>
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_synchronous">www.sqlite.org/pragma.html#pragma_synchronous</a>

```java
public void setSynchronous(SynchronousMode mode)
```

```java
public enum TempStore implements PragmaValue
```

```java
public String getValue()
```

> Changes the setting of the "hexkey" flag.
>
> @param mode One of {@link HexKeyMode}:
> <ul>
> <li>NONE - SQLite uses a string based password
> <li>SSE - the SQLite database engine will use pragma hexkey = '' to set the password
> <li>SQLCIPHER - the SQLite database engine calls pragma key = "x''" to set the password
> </ul>

```java
public void setHexKeyMode(HexKeyMode mode)
```

```java
public enum HexKeyMode implements PragmaValue
```

```java
public String getValue()
```

> Changes the setting of the "temp_store" parameter.
>
> @param storeType One of {@link TempStore}:
> <ul>
> <li>DEFAULT - the compile-time C preprocessor macro SQLITE_TEMP_STORE is used to
> determine where temporary tables and indices are stored
> <li>FILE - temporary tables and indices are stored in a file.
> </ul>
> <li>MEMORY - temporary tables and indices are kept in as if they were pure in-memory
> databases memory
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_temp_store">www.sqlite.org/pragma.html#pragma_temp_store</a>

```java
public void setTempStore(TempStore storeType)
```

> Changes the value of the sqlite3_temp_directory global variable, which many operating-system
> interface backends use to determine where to store temporary tables and indices.
>
> @param directoryName Directory name for storing temporary tables and indices.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_temp_store_directory">www.sqlite.org/pragma.html#pragma_temp_store_directory</a>

```java
public void setTempStoreDirectory(String directoryName)
```

> Set the value of the user-version. The user-version is not used internally by SQLite. It may
> be used by applications for any purpose. The value is stored in the database header at offset
> 60.
>
> @param version A big-endian 32-bit signed integer.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_user_version">www.sqlite.org/pragma.html#pragma_user_version</a>

```java
public void setUserVersion(int version)
```

> Set the value of the application-id. The application-id is not used internally by SQLite.
> Applications that use SQLite as their application file-format should set the Application ID
> integer to a unique integer so that utilities such as file(1) can determine the specific file
> type. The value is stored in the database header at offset 68.
>
> @param id A big-endian 32-bit unsigned integer.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_application_id">www.sqlite.org/pragma.html#pragma_application_id</a>

```java
public void setApplicationId(int id)
```

```java
public enum TransactionMode implements PragmaValue
```

```java
public String getValue()
```

```java
public static TransactionMode getMode(String mode)
```

> Sets the mode that will be used to start transactions.
>
> @param transactionMode One of {@link TransactionMode}.
> @see <a
> href="https://www.sqlite.org/lang_transaction.html">https://www.sqlite.org/lang_transaction.html</a>

```java
public void setTransactionMode(TransactionMode transactionMode)
```

> Sets the mode that will be used to start transactions.
>
> @param transactionMode One of DEFERRED, IMMEDIATE or EXCLUSIVE.
> @see <a
> href="https://www.sqlite.org/lang_transaction.html">https://www.sqlite.org/lang_transaction.html</a>

```java
public void setTransactionMode(String transactionMode)
```

> @return The transaction mode.

```java
public TransactionMode getTransactionMode()
```

```java
public enum DatePrecision implements PragmaValue
```

```java
public String getValue()
```

```java
public static DatePrecision getPrecision(String precision)
```

> @param datePrecision One of SECONDS or MILLISECONDS

```java
public void setDatePrecision(String datePrecision)
```

```java
public enum DateClass implements PragmaValue
```

```java
public String getValue()
```

```java
public static DateClass getDateClass(String dateClass)
```

> @param dateClass One of INTEGER, TEXT or REAL

```java
public void setDateClass(String dateClass)
```

> @param dateStringFormat Format of date string

```java
public void setDateStringFormat(String dateStringFormat)
```

> @param milliseconds Connect to DB timeout in milliseconds

```java
public void setBusyTimeout(int milliseconds)
```

```java
public int getBusyTimeout()
```

#### `org/sqlite/SQLiteConnection.java`

```java
public abstract class SQLiteConnection implements Connection
```

```java
public TransactionMode getCurrentTransactionMode()
```

```java
public void setCurrentTransactionMode(final TransactionMode currentTransactionMode)
```

```java
public void setFirstStatementExecuted(final boolean firstStatementExecuted)
```

```java
public boolean isFirstStatementExecuted()
```

```java
public SQLiteConnectionConfig getConnectionConfig()
```

```java
public CoreDatabaseMetaData getSQLiteDatabaseMetaData() throws SQLException
```

```java
    @Override
public DatabaseMetaData getMetaData() throws SQLException
```

```java
public String getUrl()
```

```java
public void setSchema(String schema) throws SQLException
```

```java
public String getSchema() throws SQLException
```

```java
public void abort(Executor executor) throws SQLException
```

```java
public void setNetworkTimeout(Executor executor, int milliseconds) throws SQLException
```

```java
public int getNetworkTimeout() throws SQLException
```

> @see java.sql.Connection#getTransactionIsolation()

```java
    @Override
public int getTransactionIsolation()
```

> @see java.sql.Connection#setTransactionIsolation(int)

```java
public void setTransactionIsolation(int level) throws SQLException
```

```java
public DB getDatabase()
```

> @see java.sql.Connection#getAutoCommit()

```java
    @Override
public boolean getAutoCommit() throws SQLException
```

> @see java.sql.Connection#setAutoCommit(boolean)

```java
    @Override
public void setAutoCommit(boolean ac) throws SQLException
```

> @return The busy timeout value for the connection.
> @see <a
> href="https://www.sqlite.org/c3ref/busy_timeout.html">https://www.sqlite.org/c3ref/busy_timeout.html</a>

```java
public int getBusyTimeout()
```

> Sets the timeout value for the connection. A timeout value less than or equal to zero turns
> off all busy handlers.
>
> @see <a
> href="https://www.sqlite.org/c3ref/busy_timeout.html">https://www.sqlite.org/c3ref/busy_timeout.html</a>
> @param timeoutMillis The timeout value in milliseconds.
> @throws SQLException

```java
public void setBusyTimeout(int timeoutMillis) throws SQLException
```

```java
public void setLimit(SQLiteLimits limit, int value) throws SQLException
```

```java
public void getLimit(SQLiteLimits limit) throws SQLException
```

```java
    @Override
public boolean isClosed() throws SQLException
```

> @see java.sql.Connection#close()

```java
    @Override
public void close() throws SQLException
```

> @return Compile-time library version numbers.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/c_source_id.html">https://www.sqlite.org/c3ref/c_source_id.html</a>

```java
public String libversion() throws SQLException
```

> @see java.sql.Connection#commit()

```java
    @Override
public void commit() throws SQLException
```

> @see java.sql.Connection#rollback()

```java
    @Override
public void rollback() throws SQLException
```

> Add a listener for DB update events, see https://www.sqlite.org/c3ref/update_hook.html
>
> @param listener The listener to receive update events

```java
public void addUpdateListener(SQLiteUpdateListener listener)
```

> Remove a listener registered for DB update events.
>
> @param listener The listener to no longer receive update events

```java
public void removeUpdateListener(SQLiteUpdateListener listener)
```

> Add a listener for DB commit/rollback events, see
> https://www.sqlite.org/c3ref/commit_hook.html
>
> @param listener The listener to receive commit events

```java
public void addCommitListener(SQLiteCommitListener listener)
```

> Remove a listener registered for DB commit/rollback events.
>
> @param listener The listener to no longer receive commit/rollback events.

```java
public void removeCommitListener(SQLiteCommitListener listener)
```

```java
final String newFilename = ...
```

> Returns a byte array representing the schema content. This method is intended for in-memory
> schemas. Serialized databases are limited to 2gb.
>
> @param schema The schema to serialize
> @return A byte[] holding the database content

```java
public byte[] serialize(String schema) throws SQLException
```

> Deserialize the schema using the given byte array. This method is intended for in-memory
> database. The call will replace the content of an existing schema. To make sure there is an
> existing schema, first execute ATTACH ':memory:' AS schema_name
>
> @param schema The schema to serialize
> @param buff The buffer to deserialize

```java
public void deserialize(String schema, byte[] buff) throws SQLException
```

#### `org/sqlite/SQLiteConnectionConfig.java`

> Connection local configurations

```java
public class SQLiteConnectionConfig implements Cloneable
```

```java
public static SQLiteConnectionConfig fromPragmaTable(Properties pragmaTable)
```

```java
public SQLiteConnectionConfig copyConfig()
```

```java
public long getDateMultiplier()
```

```java
public SQLiteConfig.DateClass getDateClass()
```

```java
public void setDateClass(SQLiteConfig.DateClass dateClass)
```

```java
public SQLiteConfig.DatePrecision getDatePrecision()
```

```java
public void setDatePrecision(SQLiteConfig.DatePrecision datePrecision)
```

```java
public String getDateStringFormat()
```

```java
public void setDateStringFormat(String dateStringFormat)
```

```java
public FastDateFormat getDateFormat()
```

```java
public boolean isAutoCommit()
```

```java
public void setAutoCommit(boolean autoCommit)
```

```java
public int getTransactionIsolation()
```

```java
public void setTransactionIsolation(int transactionIsolation)
```

```java
public SQLiteConfig.TransactionMode getTransactionMode()
```

```java
    @SuppressWarnings("deprecation")
public void setTransactionMode(SQLiteConfig.TransactionMode transactionMode)
```

#### `org/sqlite/SQLiteDataSource.java`

> Provides {@link DataSource} API for configuring SQLite database connection
>
> @author leo

```java
public class SQLiteDataSource implements DataSource
```

> Sets a data source's configuration.
>
> @param config The configuration.

```java
public void setConfig(SQLiteConfig config)
```

> @return The configuration for the data source.

```java
public SQLiteConfig getConfig()
```

> Sets the location of the database file.
>
> @param url The location of the database file.

```java
public void setUrl(String url)
```

> @return The location of the database file.

```java
public String getUrl()
```

> Sets the database name.
>
> @param databaseName The name of the database

```java
public void setDatabaseName(String databaseName)
```

> @return The name of the database if one was set.
> @see SQLiteDataSource#setDatabaseName(String)

```java
public String getDatabaseName()
```

> Enables or disables the sharing of the database cache and schema data structures between
> connections to the same database.
>
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/c3ref/enable_shared_cache.html">https://www.sqlite.org/c3ref/enable_shared_cache.html</a>

```java
public void setSharedCache(boolean enable)
```

> Enables or disables extension loading.
>
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/c3ref/load_extension.html">https://www.sqlite.org/c3ref/load_extension.html</a>

```java
public void setLoadExtension(boolean enable)
```

> Sets the database to be opened in read-only mode
>
> @param readOnly True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/c3ref/c_open_autoproxy.html">https://www.sqlite.org/c3ref/c_open_autoproxy.html</a>

```java
public void setReadOnly(boolean readOnly)
```

> Sets the amount of time that the connection's busy handler will wait when a table is locked.
>
> @param milliseconds The number of milliseconds to wait.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_busy_timeout">https://www.sqlite.org/pragma.html#pragma_busy_timeout</a>

```java
public void setBusyTimeout(int milliseconds)
```

> Sets the suggested maximum number of database disk pages that SQLite will hold in memory at
> once per open database file.
>
> @param numberOfPages The number of database disk pages.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_cache_size">https://www.sqlite.org/pragma.html#pragma_cache_size</a>

```java
public void setCacheSize(int numberOfPages)
```

> Enables or disables case sensitivity for the built-in LIKE operator.
>
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/compile.html#case_sensitive_like">https://www.sqlite.org/compile.html#case_sensitive_like</a>

```java
public void setCaseSensitiveLike(boolean enable)
```

> Enables or disables the count-changes flag. When enabled INSERT, UPDATE and DELETE statements
> return the number of rows they modified.
>
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_count_changes">https://www.sqlite.org/pragma.html#pragma_count_changes</a>

```java
public void setCountChanges(boolean enable)
```

> Sets the default maximum number of database disk pages that SQLite will hold in memory at
> once per open database file.
>
> @param numberOfPages The default suggested cache size.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_cache_size">https://www.sqlite.org/pragma.html#pragma_cache_size</a>

```java
public void setDefaultCacheSize(int numberOfPages)
```

> Sets the text encoding used by the main database.
>
> @param encoding One of "UTF-8", "UTF-16le" (little-endian UTF-16) or "UTF-16be" (big-endian
> UTF-16).
> @see <a href="https://www.sqlite.org/pragma.html#pragma_encoding">
> https://www.sqlite.org/pragma.html#pragma_encoding</a>

```java
public void setEncoding(String encoding)
```

> Enables or disables the enforcement of foreign key constraints.
>
> @param enforce True to enable; false to disable.
> @see <a href="https://www.sqlite.org/pragma.html#pragma_foreign_keys">
> https://www.sqlite.org/pragma.html#pragma_foreign_keys</a>

```java
public void setEnforceForeignKeys(boolean enforce)
```

> Enables or disables the full_column_names flag. This flag together with the
> short_column_names flag determine the way SQLite assigns names to result columns of SELECT
> statements.
>
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_full_column_names">https://www.sqlite.org/pragma.html#pragma_full_column_names</a>

```java
public void setFullColumnNames(boolean enable)
```

> Enables or disables the fullfsync flag. This flag determines whether or not the F_FULLFSYNC
> syncing method is used on systems that support it.
>
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_fullfsync">https://www.sqlite.org/pragma.html#pragma_fullfsync</a>

```java
public void setFullSync(boolean enable)
```

> Set the incremental_vacuum value that causes up to N pages to be removed from the <a
> href="https://www.sqlite.org/fileformat2.html#freelist">https://www.sqlite.org/fileformat2.html#freelist</a>.
>
> @param numberOfPagesToBeRemoved
> @see <a href="https://www.sqlite.org/pragma.html#pragma_incremental_vacuum">
> https://www.sqlite.org/pragma.html#pragma_incremental_vacuum</a>

```java
public void setIncrementalVacuum(int numberOfPagesToBeRemoved)
```

> Sets the journal mode for databases associated with the current database connection.
>
> @param mode One of DELETE, TRUNCATE, PERSIST, MEMORY, WAL or OFF.
> @see <a href="https://www.sqlite.org/pragma.html#pragma_journal_mode">
> https://www.sqlite.org/pragma.html#pragma_journal_mode</a>

```java
public void setJournalMode(String mode)
```

> Sets the limit of the size of rollback-journal and WAL files left in the file-system after
> transactions or checkpoints.
>
> @param limit The default journal size limit is -1 (no limit).
> @see <a href="https://www.sqlite.org/pragma.html#pragma_journal_size_limit">
> https://www.sqlite.org/pragma.html#pragma_journal_size_limit</a>

```java
public void setJournalSizeLimit(int limit)
```

> Set the value of the legacy_file_format flag. When this flag is on, new databases are created
> in a file format that is readable and writable by all versions of SQLite going back to 3.0.0.
> When the flag is off, new databases are created using the latest file format which might not
> be readable or writable by versions of SQLite prior to 3.3.0.
>
> @param use True to turn on; false to turn off.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_legacy_file_format">https://www.sqlite.org/pragma.html#pragma_legacy_file_format</a>

```java
public void setLegacyFileFormat(boolean use)
```

> Sets the value of the legacy_alter_table flag. When this flag is on, the ALTER TABLE RENAME
> command (for changing the name of a table) works as it did in SQLite 3.24.0 (2018-06-04) and
> earlier.When the flag is off, using the ALTER TABLE RENAME command will mean that all
> references to the table anywhere in the schema will be converted to the new name.
>
> @param flag True to turn on legacy alter table behaviour; false to turn off.
> @see <a href="https://www.sqlite.org/pragma.html#pragma_legacy_alter_table</a>

```java
public void setLegacyAlterTable(boolean flag)
```

> Sets the database connection locking-mode.
>
> @param mode Either NORMAL or EXCLUSIVE.
> @see <a href="https://www.sqlite.org/pragma.html#pragma_locking_mode">
> https://www.sqlite.org/pragma.html#pragma_locking_mode</a>

```java
public void setLockingMode(String mode)
```

> Set the page size of the database.
>
> @param numBytes The page size must be a power of two between 512 and 65536 inclusive.
> @see <a href="https://www.sqlite.org/pragma.html#pragma_page_size">
> https://www.sqlite.org/pragma.html#pragma_page_size</a>

```java
public void setPageSize(int numBytes)
```

> Set the maximum number of pages in the database file.
>
> @param numPages The maximum page count cannot be reduced below the current database size.
> @see <a href="https://www.sqlite.org/pragma.html#pragma_max_page_count">
> https://www.sqlite.org/pragma.html#pragma_max_page_count</a>

```java
public void setMaxPageCount(int numPages)
```

> Set READ UNCOMMITTED isolation
>
> @param useReadUncommittedIsolationMode True to turn on; false to turn off.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_read_uncommitted">https://www.sqlite.org/pragma.html#pragma_read_uncommitted</a>

```java
public void setReadUncommitted(boolean useReadUncommittedIsolationMode)
```

> Enables or disables the recursive trigger capability. Changing the recursive_triggers setting
> affects the execution of all statements prepared using the database connection, including
> those prepared before the setting was changed.
>
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_recursive_triggers">https://www.sqlite.org/pragma.html#pragma_recursive_triggers</a>

```java
public void setRecursiveTriggers(boolean enable)
```

> Enables or disables the reverse_unordered_selects flag. When enabled it causes SELECT
> statements without an ORDER BY clause to emit their results in the reverse order of what they
> normally would.
>
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_reverse_unordered_selects">https://www.sqlite.org/pragma.html#pragma_reverse_unordered_selects</a>

```java
public void setReverseUnorderedSelects(boolean enable)
```

> Enables or disables the short_column_names flag. This flag affects the way SQLite names
> columns of data returned by SELECT statements.
>
> @param enable True to enable; false to disable.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_short_column_names">https://www.sqlite.org/pragma.html#pragma_short_column_names</a>
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_fullfsync">https://www.sqlite.org/pragma.html#pragma_fullfsync</a>

```java
public void setShortColumnNames(boolean enable)
```

> Sets the setting of the "synchronous" flag.
>
> @param mode One of OFF, NORMAL or FULL;
> @see <a href="https://www.sqlite.org/pragma.html#pragma_synchronous">
> https://www.sqlite.org/pragma.html#pragma_synchronous</a>

```java
public void setSynchronous(String mode)
```

> Set the temp_store type which is used to determine where temporary tables and indices are
> stored.
>
> @param storeType One of "DEFAULT", "FILE", "MEMORY"
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_temp_store">https://www.sqlite.org/pragma.html#pragma_temp_store</a>

```java
public void setTempStore(String storeType)
```

> Set the value of the sqlite3_temp_directory global variable, which many operating-system
> interface backends use to determine where to store temporary tables and indices.
>
> @param directoryName The temporary directory name.
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_temp_store_directory">https://www.sqlite.org/pragma.html#pragma_temp_store_directory</a>

```java
public void setTempStoreDirectory(String directoryName)
```

> Sets the mode that will be used to start transactions for this database.
>
> @param transactionMode One of DEFERRED, IMMEDIATE or EXCLUSIVE.
> @see <a
> href="https://www.sqlite.org/lang_transaction.html">https://www.sqlite.org/lang_transaction.html</a>

```java
public void setTransactionMode(String transactionMode)
```

> Sets the value of the user-version. It is a big-endian 32-bit signed integer stored in the
> database header at offset 60.
>
> @param version
> @see <a
> href="https://www.sqlite.org/pragma.html#pragma_schema_version">https://www.sqlite.org/pragma.html#pragma_schema_version</a>

```java
public void setUserVersion(int version)
```

> @see javax.sql.DataSource#getConnection()

```java
public Connection getConnection() throws SQLException
```

> @see javax.sql.DataSource#getConnection(java.lang.String, java.lang.String)

```java
public SQLiteConnection getConnection(String username, String password) throws SQLException
```

> @see javax.sql.DataSource#getLogWriter()

```java
public PrintWriter getLogWriter() throws SQLException
```

> @see javax.sql.DataSource#getLoginTimeout()

```java
public int getLoginTimeout() throws SQLException
```

```java
public Logger getParentLogger() throws SQLFeatureNotSupportedException
```

> @see javax.sql.DataSource#setLogWriter(java.io.PrintWriter)

```java
public void setLogWriter(PrintWriter out) throws SQLException
```

> @see javax.sql.DataSource#setLoginTimeout(int)

```java
public void setLoginTimeout(int seconds) throws SQLException
```

> Determines if this object wraps a given class.
>
> @param iface The class to check.
> @return True if it is an instance of the current class; false otherwise.
> @throws SQLException

```java
public boolean isWrapperFor(Class<?> iface) throws SQLException
```

> Casts this object to the given class.
>
> @param iface The class to cast to.
> @return The casted class.
> @throws SQLException

```java
    @SuppressWarnings("unchecked")
public <T> T unwrap(Class<T> iface) throws SQLException
```

#### `org/sqlite/SQLiteErrorCode.java`

> SQLite3 error code
>
> @author leo
> @see <a
> href="https://www.sqlite.org/c3ref/c_abort.html">https://www.sqlite.org/c3ref/c_abort.html</a>

```java
public enum SQLiteErrorCode
```

```java
public final int code ;
```

```java
public final String message ;
```

> @param errorCode Error code.
> @return Error message.

```java
public static SQLiteErrorCode getErrorCode(int errorCode)
```

> @see java.lang.Enum#toString()

```java
    @Override
public String toString()
```

#### `org/sqlite/SQLiteException.java`

```java
public class SQLiteException extends SQLException
```

```java
public SQLiteErrorCode getResultCode()
```

#### `org/sqlite/SQLiteJDBCLoader.java`

> Set the system properties, org.sqlite.lib.path, org.sqlite.lib.name, appropriately so that the
> SQLite JDBC driver can find *.dll, *.dylib and *.so files, according to the current OS (win,
> linux, mac).
>
> <p>The library files are automatically extracted from this project's package (JAR).
>
> <p>usage: call {@link #initialize()} before using SQLite JDBC driver.
>
> @author leo

```java
public class SQLiteJDBCLoader
```

> Loads SQLite native JDBC library.
>
> @return True if SQLite native library is successfully loaded; false otherwise.

```java
public static synchronized boolean initialize() throws Exception
```

> Deleted old native libraries e.g. on Windows the DLL file is not removed on VM-Exit (bug #80)

```java
static void cleanup()
```

> Checks if the SQLite JDBC driver is set to native mode.
>
> @return True if the SQLite JDBC driver is set to native Java mode; false otherwise.

```java
public static boolean isNativeMode() throws Exception
```

> Computes the MD5 value of the input stream.
>
> @param input InputStream.
> @return Encrypted string for the InputStream.
> @throws IOException
> @throws NoSuchAlgorithmException

```java
static String md5sum(InputStream input) throws IOException
```

> @return The major version of the SQLite JDBC driver.

```java
public static int getMajorVersion()
```

> @return The minor version of the SQLite JDBC driver.

```java
public static int getMinorVersion()
```

> @return The version of the SQLite JDBC driver.

```java
public static String getVersion()
```

> This class will load the version from resources during <clinit>. By initializing this at
> build-time in native-image, the resources do not need to be included in the native
> executable, and we're eliminating the IO operations as well.

```java
public static final class VersionHolder
```

#### `org/sqlite/SQLiteLimits.java`

```java
public enum SQLiteLimits
```

```java
public int getId()
```

#### `org/sqlite/SQLiteOpenMode.java`

> Database file open modes of SQLite.
>
> <p>See also https://www.sqlite.org/c3ref/open.html
>
> @author leo

```java
public enum SQLiteOpenMode
```

```java
public final int flag ;
```

#### `org/sqlite/SQLiteUpdateListener.java`

> https://www.sqlite.org/c3ref/update_hook.html

```java
public interface SQLiteUpdateListener
```

```java
public enum Type
```

#### `org/sqlite/core/Codes.java`

```java
public interface Codes
```

> Successful result

```java
public static final int SQLITE_OK = ...
```

> SQL error or missing database

```java
public static final int SQLITE_ERROR = ...
```

> An internal logic error in SQLite

```java
public static final int SQLITE_INTERNAL = ...
```

> Access permission denied

```java
public static final int SQLITE_PERM = ...
```

> Callback routine requested an abort

```java
public static final int SQLITE_ABORT = ...
```

> The database file is locked

```java
public static final int SQLITE_BUSY = ...
```

> A table in the database is locked

```java
public static final int SQLITE_LOCKED = ...
```

> A malloc() failed

```java
public static final int SQLITE_NOMEM = ...
```

> Attempt to write a readonly database

```java
public static final int SQLITE_READONLY = ...
```

> Operation terminated by sqlite_interrupt()

```java
public static final int SQLITE_INTERRUPT = ...
```

> Some kind of disk I/O error occurred

```java
public static final int SQLITE_IOERR = ...
```

> The database disk image is malformed

```java
public static final int SQLITE_CORRUPT = ...
```

> (Internal Only) Table or record not found

```java
public static final int SQLITE_NOTFOUND = ...
```

> Insertion failed because database is full

```java
public static final int SQLITE_FULL = ...
```

> Unable to open the database file

```java
public static final int SQLITE_CANTOPEN = ...
```

> Database lock protocol error

```java
public static final int SQLITE_PROTOCOL = ...
```

> (Internal Only) Database table is empty

```java
public static final int SQLITE_EMPTY = ...
```

> The database schema changed

```java
public static final int SQLITE_SCHEMA = ...
```

> Too much data for one row of a table

```java
public static final int SQLITE_TOOBIG = ...
```

> Abort due to constraint violation

```java
public static final int SQLITE_CONSTRAINT = ...
```

> Data type mismatch

```java
public static final int SQLITE_MISMATCH = ...
```

> Library used incorrectly

```java
public static final int SQLITE_MISUSE = ...
```

> Uses OS features not supported on host

```java
public static final int SQLITE_NOLFS = ...
```

> Authorization denied

```java
public static final int SQLITE_AUTH = ...
```

> sqlite_step() has another row ready

```java
public static final int SQLITE_ROW = ...
```

> sqlite_step() has finished executing

```java
public static final int SQLITE_DONE = ...
```

```java
public static final int SQLITE_INTEGER = ...
```

```java
public static final int SQLITE_FLOAT = ...
```

```java
public static final int SQLITE_TEXT = ...
```

```java
public static final int SQLITE_BLOB = ...
```

```java
public static final int SQLITE_NULL = ...
```

#### `org/sqlite/core/CoreDatabaseMetaData.java`

```java
public abstract class CoreDatabaseMetaData implements DatabaseMetaData
```

> @deprecated Not exactly sure what this function does, as it is not implementing any
> interface, and is not used anywhere in the code. Deprecated since 3.43.0.0.

```java
    @Deprecated
public abstract ResultSet getGeneratedKeys() throws SQLException ;
```

> @throws SQLException

```java
public synchronized void close() throws SQLException
```

#### `org/sqlite/core/CorePreparedStatement.java`

```java
public abstract class CorePreparedStatement extends JDBC4Statement
```

> @see org.sqlite.jdbc3.JDBC3Statement#executeBatch()

```java
    @Override
public int[] executeBatch() throws SQLException
```

> @see org.sqlite.jdbc3.JDBC3Statement#executeLargeBatch()

```java
    @Override
public long[] executeLargeBatch() throws SQLException
```

> @see org.sqlite.jdbc3.JDBC3Statement#clearBatch() ()

```java
    @Override
public void clearBatch() throws SQLException
```

#### `org/sqlite/core/CoreResultSet.java`

> Implements a JDBC ResultSet.

```java
public abstract class CoreResultSet implements Codes
```

> If the result set does not have any rows.

```java
public boolean emptyResultSet = ...
```

> If the result set is open. Doesn't mean it has results.

```java
public boolean open = ...
```

> Maximum number of rows as set by a Statement

```java
public long maxRows ;
```

> if null, the RS is closed()

```java
public String[] cols = ...
```

> same as cols, but used by Meta interface

```java
public String[] colsMeta = ...
```

```java
public boolean closeStmt ;
```

> Checks the status of the result set.
>
> @return True if has results and can iterate them; false otherwise.

```java
public boolean isOpen()
```

> Takes col in [1,x] form, returns in [0,x-1] form
>
> @param col
> @return
> @throws SQLException

```java
public int checkCol(int col) throws SQLException
```

> @throws SQLException

```java
public void checkMeta() throws SQLException
```

```java
public void close() throws SQLException
```

#### `org/sqlite/core/CoreStatement.java`

```java
public abstract class CoreStatement implements Codes
```

```java
public final SQLiteConnection conn ;
```

```java
public SafeStmtPtr pointer ;
```

```java
public DB getDatabase()
```

```java
public SQLiteConnectionConfig getConnectionConfig()
```

```java
public abstract ResultSet executeQuery(String sql, boolean closeStmt) throws SQLException ;
```

> SQLite's last_insert_rowid() function is DB-specific. However, in this implementation we
> ensure the Generated Key result set is statement-specific by executing the query immediately
> after an insert operation is performed. The caller is simply responsible for calling
> updateGeneratedKeys on the statement object right after execute in a synchronized(connection)
> block.

```java
public void updateGeneratedKeys() throws SQLException
```

> This implementation uses SQLite's last_insert_rowid function to obtain the row ID. It cannot
> provide multiple values when inserting multiple rows. Suggestion is to use a <a
> href=https://www.sqlite.org/lang_returning.html>RETURNING</a> clause instead.
>
> @see java.sql.Statement#getGeneratedKeys()

```java
public ResultSet getGeneratedKeys() throws SQLException
```

#### `org/sqlite/core/DB.java`

```java
public abstract class DB implements Codes
```

```java
public String getUrl()
```

```java
public boolean isClosed()
```

```java
public SQLiteConfig getConfig()
```

> Aborts any pending operation and returns at its earliest opportunity.
>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/interrupt.html">https://www.sqlite.org/c3ref/interrupt.html</a>

```java
public abstract void interrupt() throws SQLException ;
```

> Sets a <a href="https://www.sqlite.org/c3ref/busy_handler.html">busy handler</a> that sleeps
> for a specified amount of time when a table is locked.
>
> @param ms Time to sleep in milliseconds.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/busy_timeout.html">https://www.sqlite.org/c3ref/busy_timeout.html</a>

```java
public abstract void busy_timeout(int ms) throws SQLException ;
```

> Sets a <a href="https://www.sqlite.org/c3ref/busy_handler.html">busy handler</a> that sleeps
> for a specified amount of time when a table is locked.
>
> @param busyHandler
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/busy_handler.html">https://www.sqlite.org/c3ref/busy_timeout.html</a>

```java
public abstract void busy_handler(BusyHandler busyHandler) throws SQLException ;
```

> Return English-language text that describes the error as either UTF-8 or UTF-16.
>
> @return Error description in English.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/errcode.html">https://www.sqlite.org/c3ref/errcode.html</a>

```java
abstract String errmsg() throws SQLException ;
```

> Returns the value for SQLITE_VERSION, SQLITE_VERSION_NUMBER, and SQLITE_SOURCE_ID C
> preprocessor macros that are associated with the library.
>
> @return Compile-time SQLite version information.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/libversion.html">https://www.sqlite.org/c3ref/libversion.html</a>
> @see <a
> href="https://www.sqlite.org/c3ref/c_source_id.html">https://www.sqlite.org/c3ref/c_source_id.html</a>

```java
public abstract String libversion() throws SQLException ;
```

> @return Number of rows that were changed, inserted or deleted by the last SQL statement
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/changes.html">https://www.sqlite.org/c3ref/changes.html</a>

```java
public abstract long changes() throws SQLException ;
```

> @return Number of row changes caused by INSERT, UPDATE or DELETE statements since the
> database connection was opened.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/total_changes.html">https://www.sqlite.org/c3ref/total_changes.html</a>

```java
public abstract long total_changes() throws SQLException ;
```

> Enables or disables the sharing of the database cache and schema data structures between
> connections to the same database.
>
> @param enable True to enable; false otherwise.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/enable_shared_cache.html">https://www.sqlite.org/c3ref/enable_shared_cache.html</a>
> @see org.sqlite.SQLiteErrorCode

```java
public abstract int shared_cache(boolean enable) throws SQLException ;
```

> Enables or disables loading of SQLite extensions.
>
> @param enable True to enable; false otherwise.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/load_extension.html">https://www.sqlite.org/c3ref/load_extension.html</a>

```java
public abstract int enable_load_extension(boolean enable) throws SQLException ;
```

> Executes an SQL statement using the process of compiling, evaluating, and destroying the
> prepared statement object.
>
> @param sql SQL statement to be executed.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/exec.html">https://www.sqlite.org/c3ref/exec.html</a>

```java
public final synchronized void exec(String sql, boolean autoCommit) throws SQLException
```

> Creates an SQLite interface to a database for the given connection.
>
> @param file The database.
> @param openFlags File opening configurations (<a
> href="https://www.sqlite.org/c3ref/c_open_autoproxy.html">https://www.sqlite.org/c3ref/c_open_autoproxy.html</a>)
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/open.html">https://www.sqlite.org/c3ref/open.html</a>

```java
public final synchronized void open(String file, int openFlags) throws SQLException
```

> Closes a database connection and finalizes any remaining statements before the closing
> operation.
>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/close.html">https://www.sqlite.org/c3ref/close.html</a>

```java
public final synchronized void close() throws SQLException
```

> Complies the an SQL statement.
>
> @param stmt The SQL statement to compile.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/prepare.html">https://www.sqlite.org/c3ref/prepare.html</a>

```java
public final synchronized void prepare(CoreStatement stmt) throws SQLException
```

```java
final boolean added = ...
```

> Destroys a statement.
>
> @param safePtr the pointer wrapper to remove from internal structures
> @param ptr the raw pointer to free
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException if finalization fails
> @see <a
> href="https://www.sqlite.org/c3ref/finalize.html">https://www.sqlite.org/c3ref/finalize.html</a>

```java
public synchronized int finalize(SafeStmtPtr safePtr, long ptr) throws SQLException
```

> Complies, evaluates, executes and commits an SQL statement.
>
> @param sql An SQL statement.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/exec.html">https://www.sqlite.org/c3ref/exec.html</a>

```java
public abstract int _exec(String sql) throws SQLException ;
```

> Evaluates a statement.
>
> @param stmt Pointer to the statement.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/step.html">https://www.sqlite.org/c3ref/step.html</a>

```java
public abstract int step(long stmt) throws SQLException ;
```

> Sets a prepared statement object back to its initial state, ready to be re-executed.
>
> @param stmt Pointer to the statement.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/reset.html">https://www.sqlite.org/c3ref/reset.html</a>

```java
public abstract int reset(long stmt) throws SQLException ;
```

> Reset all bindings on a prepared statement (reset all host parameters to NULL).
>
> @param stmt Pointer to the statement.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/clear_bindings.html">https://www.sqlite.org/c3ref/clear_bindings.html</a>

```java
public abstract int clear_bindings(long stmt) throws SQLException ;
```

> @param stmt Pointer to the statement.
> @return Number of parameters in a prepared SQL.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/bind_parameter_count.html">https://www.sqlite.org/c3ref/bind_parameter_count.html</a>

```java
abstract int bind_parameter_count(long stmt) throws SQLException ;
```

> @param stmt Pointer to the statement.
> @return Number of columns in the result set returned by the prepared statement.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/column_count.html">https://www.sqlite.org/c3ref/column_count.html</a>

```java
public abstract int column_count(long stmt) throws SQLException ;
```

> @param stmt Pointer to the statement.
> @param col Number of column.
> @return Datatype code for the initial data type of the result column.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/column_blob.html">https://www.sqlite.org/c3ref/column_blob.html</a>

```java
public abstract int column_type(long stmt, int col) throws SQLException ;
```

> @param stmt Pointer to the statement.
> @param col Number of column.
> @return Declared type of the table column for prepared statement.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/column_decltype.html">https://www.sqlite.org/c3ref/column_decltype.html</a>

```java
public abstract String column_decltype(long stmt, int col) throws SQLException ;
```

> @param stmt Pointer to the statement.
> @param col Number of column.
> @return Original text of column name which is the declared in the CREATE TABLE statement.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/column_database_name.html">https://www.sqlite.org/c3ref/column_database_name.html</a>

```java
public abstract String column_table_name(long stmt, int col) throws SQLException ;
```

> @param stmt Pointer to the statement.
> @param col The number of column.
> @return Name assigned to a particular column in the result set of a SELECT statement.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/column_name.html">https://www.sqlite.org/c3ref/column_name.html</a>

```java
public abstract String column_name(long stmt, int col) throws SQLException ;
```

> @param stmt Pointer to the statement.
> @param col Number of column.
> @return Value of the column as text data type in the result set of a SELECT statement.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/column_blob.html">https://www.sqlite.org/c3ref/column_blob.html</a>

```java
public abstract String column_text(long stmt, int col) throws SQLException ;
```

> @param stmt Pointer to the statement.
> @param col Number of column.
> @return BLOB value of the column in the result set of a SELECT statement
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/column_blob.html">https://www.sqlite.org/c3ref/column_blob.html</a>

```java
public abstract byte[] column_blob(long stmt, int col) throws SQLException ;
```

> @param stmt Pointer to the statement.
> @param col Number of column.
> @return DOUBLE value of the column in the result set of a SELECT statement
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/column_blob.html">https://www.sqlite.org/c3ref/column_blob.html</a>

```java
public abstract double column_double(long stmt, int col) throws SQLException ;
```

> @param stmt Pointer to the statement.
> @param col Number of column.
> @return LONG value of the column in the result set of a SELECT statement.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/column_blob.html">https://www.sqlite.org/c3ref/column_blob.html</a>

```java
public abstract long column_long(long stmt, int col) throws SQLException ;
```

> @param stmt Pointer to the statement.
> @param col Number of column.
> @return INT value of column in the result set of a SELECT statement.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/column_blob.html">https://www.sqlite.org/c3ref/column_blob.html</a>

```java
public abstract int column_int(long stmt, int col) throws SQLException ;
```

> Binds NULL value to prepared statements with the pointer to the statement object and the
> index of the SQL parameter to be set to NULL.
>
> @param stmt Pointer to the statement.
> @param pos The index of the SQL parameter to be set to NULL.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException

```java
abstract int bind_null(long stmt, int pos) throws SQLException ;
```

> Binds int value to prepared statements with the pointer to the statement object, the index of
> the SQL parameter to be set and the value to bind to the parameter.
>
> @param stmt Pointer to the statement.
> @param pos The index of the SQL parameter to be set.
> @param v Value to bind to the parameter.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/bind_blob.html">https://www.sqlite.org/c3ref/bind_blob.html</a>

```java
abstract int bind_int(long stmt, int pos, int v) throws SQLException ;
```

> Binds long value to prepared statements with the pointer to the statement object, the index
> of the SQL parameter to be set and the value to bind to the parameter.
>
> @param stmt Pointer to the statement.
> @param pos The index of the SQL parameter to be set.
> @param v Value to bind to the parameter.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/bind_blob.html">https://www.sqlite.org/c3ref/bind_blob.html</a>

```java
abstract int bind_long(long stmt, int pos, long v) throws SQLException ;
```

> Binds double value to prepared statements with the pointer to the statement object, the index
> of the SQL parameter to be set and the value to bind to the parameter.
>
> @param stmt Pointer to the statement.
> @param pos Index of the SQL parameter to be set.
> @param v Value to bind to the parameter.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/bind_blob.html">https://www.sqlite.org/c3ref/bind_blob.html</a>

```java
abstract int bind_double(long stmt, int pos, double v) throws SQLException ;
```

> Binds text value to prepared statements with the pointer to the statement object, the index
> of the SQL parameter to be set and the value to bind to the parameter.
>
> @param stmt Pointer to the statement.
> @param pos Index of the SQL parameter to be set.
> @param v value to bind to the parameter.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/bind_blob.html">https://www.sqlite.org/c3ref/bind_blob.html</a>

```java
abstract int bind_text(long stmt, int pos, String v) throws SQLException ;
```

> Binds blob value to prepared statements with the pointer to the statement object, the index
> of the SQL parameter to be set and the value to bind to the parameter.
>
> @param stmt Pointer to the statement.
> @param pos Index of the SQL parameter to be set.
> @param v Value to bind to the parameter.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/bind_blob.html">https://www.sqlite.org/c3ref/bind_blob.html</a>

```java
abstract int bind_blob(long stmt, int pos, byte[] v) throws SQLException ;
```

> Sets the result of an SQL function as NULL with the pointer to the SQLite database context.
>
> @param context Pointer to the SQLite database context.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/result_blob.html">https://www.sqlite.org/c3ref/result_blob.html</a>

```java
public abstract void result_null(long context) throws SQLException ;
```

> Sets the result of an SQL function as text data type with the pointer to the SQLite database
> context and the the result value of String.
>
> @param context Pointer to the SQLite database context.
> @param val Result value of an SQL function.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/result_blob.html">https://www.sqlite.org/c3ref/result_blob.html</a>

```java
public abstract void result_text(long context, String val) throws SQLException ;
```

> Sets the result of an SQL function as blob data type with the pointer to the SQLite database
> context and the the result value of byte array.
>
> @param context Pointer to the SQLite database context.
> @param val Result value of an SQL function.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/result_blob.html">https://www.sqlite.org/c3ref/result_blob.html</a>

```java
public abstract void result_blob(long context, byte[] val) throws SQLException ;
```

> Sets the result of an SQL function as double data type with the pointer to the SQLite
> database context and the the result value of double.
>
> @param context Pointer to the SQLite database context.
> @param val Result value of an SQL function.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/result_blob.html">https://www.sqlite.org/c3ref/result_blob.html</a>

```java
public abstract void result_double(long context, double val) throws SQLException ;
```

> Sets the result of an SQL function as long data type with the pointer to the SQLite database
> context and the the result value of long.
>
> @param context Pointer to the SQLite database context.
> @param val Result value of an SQL function.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/result_blob.html">https://www.sqlite.org/c3ref/result_blob.html</a>

```java
public abstract void result_long(long context, long val) throws SQLException ;
```

> Sets the result of an SQL function as int data type with the pointer to the SQLite database
> context and the the result value of int.
>
> @param context Pointer to the SQLite database context.
> @param val Result value of an SQL function.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/result_blob.html">https://www.sqlite.org/c3ref/result_blob.html</a>

```java
public abstract void result_int(long context, int val) throws SQLException ;
```

> Sets the result of an SQL function as an error with the pointer to the SQLite database
> context and the the error of String.
>
> @param context Pointer to the SQLite database context.
> @param err Error result of an SQL function.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/result_blob.html">https://www.sqlite.org/c3ref/result_blob.html</a>

```java
public abstract void result_error(long context, String err) throws SQLException ;
```

> @param f SQLite function object.
> @param arg Pointer to the parameter of the SQLite function or aggregate.
> @return Parameter value of the given SQLite function or aggregate in text data type.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/value_blob.html">https://www.sqlite.org/c3ref/value_blob.html</a>

```java
public abstract String value_text(Function f, int arg) throws SQLException ;
```

> @param f SQLite function object.
> @param arg Pointer to the parameter of the SQLite function or aggregate.
> @return Parameter value of the given SQLite function or aggregate in blob data type.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/value_blob.html">https://www.sqlite.org/c3ref/value_blob.html</a>

```java
public abstract byte[] value_blob(Function f, int arg) throws SQLException ;
```

> @param f SQLite function object.
> @param arg Pointer to the parameter of the SQLite function or aggregate.
> @return Parameter value of the given SQLite function or aggregate in double data type
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/value_blob.html">https://www.sqlite.org/c3ref/value_blob.html</a>

```java
public abstract double value_double(Function f, int arg) throws SQLException ;
```

> @param f SQLite function object.
> @param arg Pointer to the parameter of the SQLite function or aggregate.
> @return Parameter value of the given SQLite function or aggregate in long data type.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/value_blob.html">https://www.sqlite.org/c3ref/value_blob.html</a>

```java
public abstract long value_long(Function f, int arg) throws SQLException ;
```

> Accesses the parameter values on the function or aggregate in int data type with the function
> object and the parameter value.
>
> @param f SQLite function object.
> @param arg Pointer to the parameter of the SQLite function or aggregate.
> @return Parameter value of the given SQLite function or aggregate.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/value_blob.html">https://www.sqlite.org/c3ref/value_blob.html</a>

```java
public abstract int value_int(Function f, int arg) throws SQLException ;
```

> @param f SQLite function object.
> @param arg Pointer to the parameter of the SQLite function or aggregate.
> @return Parameter datatype of the function or aggregate in int data type.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/value_blob.html">https://www.sqlite.org/c3ref/value_blob.html</a>

```java
public abstract int value_type(Function f, int arg) throws SQLException ;
```

> Create a user defined function with given function name and the function object.
>
> @param name The function name to be created.
> @param f SQLite function object.
> @param flags Extra flags to use when creating the function, such as {@link
> Function#FLAG_DETERMINISTIC}
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/create_function.html">https://www.sqlite.org/c3ref/create_function.html</a>

```java
public abstract int create_function(String name, Function f, int nArgs, int flags)
```

> De-registers a user defined function
>
> @param name Name of the function to de-registered.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException

```java
public abstract int destroy_function(String name) throws SQLException ;
```

> Create a user defined collation with given collation name and the collation object.
>
> @param name The collation name to be created.
> @param c SQLite collation object.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/create_collation.html">https://www.sqlite.org/c3ref/create_collation.html</a>

```java
public abstract int create_collation(String name, Collation c) throws SQLException ;
```

> Create a user defined collation with given collation name and the collation object.
>
> @param name The collation name to be created.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException

```java
public abstract int destroy_collation(String name) throws SQLException ;
```

> @param dbName Database name to be backed up.
> @param destFileName Target backup file name.
> @param observer ProgressObserver object.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException

```java
public abstract int backup(String dbName, String destFileName, ProgressObserver observer)
```

> @param dbName Database name to be backed up.
> @param destFileName Target backup file name.
> @param observer ProgressObserver object.
> @param sleepTimeMillis time to wait during a backup/restore operation if sqlite3_backup_step
> returns SQLITE_BUSY before continuing
> @param nTimeouts the number of times sqlite3_backup_step can return SQLITE_BUSY before
> failing
> @param pagesPerStep the number of pages to copy in each sqlite3_backup_step. If this is
> negative, the entire DB is copied at once.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException

```java
public abstract int backup(
            String dbName,
            String destFileName,
            ProgressObserver observer,
            int sleepTimeMillis,
            int nTimeouts,
            int pagesPerStep)
```

> @param dbName Database name for restoring data.
> @param sourceFileName Source file name.
> @param observer ProgressObserver object.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException

```java
public abstract int restore(String dbName, String sourceFileName, ProgressObserver observer)
```

> @param dbName the name of the db to restore
> @param sourceFileName the filename of the source db to restore
> @param observer ProgressObserver object.
> @param sleepTimeMillis time to wait during a backup/restore operation if sqlite3_backup_step
> returns SQLITE_BUSY before continuing
> @param nTimeouts the number of times sqlite3_backup_step can return SQLITE_BUSY before
> failing
> @param pagesPerStep the number of pages to copy in each sqlite3_backup_step. If this is
> negative, the entire DB is copied at once.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException

```java
public abstract int restore(
            String dbName,
            String sourceFileName,
            ProgressObserver observer,
            int sleepTimeMillis,
            int nTimeouts,
            int pagesPerStep)
```

> @param id The id of the limit.
> @param value The new value of the limit.
> @return The prior value of the limit
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/limit.html">https://www.sqlite.org/c3ref/limit.html</a>

```java
public abstract int limit(int id, int value) throws SQLException ;
```

```java
public interface ProgressObserver
```

> Progress handler

```java
public abstract void register_progress_handler(int vmCalls, ProgressHandler progressHandler)
```

```java
public abstract void clear_progress_handler() throws SQLException ;
```

> Returns an array describing the attributes (not null, primary key and auto increment) of
> columns.
>
> @param stmt Pointer to the statement.
> @return Column attribute array.<br>
> index[col][0] = true if column constrained NOT NULL;<br>
> index[col][1] = true if column is part of the primary key; <br>
> index[col][2] = true if column is auto-increment.
> @throws SQLException

```java
abstract boolean[][] column_metadata(long stmt) throws SQLException ;
```

> Returns an array of column names in the result set of the SELECT statement.
>
> @param stmt Stmt object.
> @return String array of column names.
> @throws SQLException

```java
public final synchronized String[] column_names(long stmt) throws SQLException
```

> Bind values to prepared statements
>
> @param stmt Pointer to the statement.
> @param pos Index of the SQL parameter to be set to NULL.
> @param v Value to bind to the parameter.
> @return <a href="https://www.sqlite.org/c3ref/c_abort.html">Result Codes</a>
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/bind_blob.html">https://www.sqlite.org/c3ref/bind_blob.html</a>

```java
final synchronized int sqlbind(long stmt, int pos, Object v) throws SQLException
```

> Submits a batch of commands to the database for execution.
>
> @see java.sql.Statement#executeBatch()
> @param stmt Pointer of Stmt object.
> @param count Number of SQL statements.
> @param vals Array of parameter values.
> @return Array of the number of rows changed or inserted or deleted for each command if all
> commands execute successfully;
> @throws SQLException if statement is not open or is being used elsewhere

```java
final synchronized long[] executeBatch(
            SafeStmtPtr stmt, int count, Object[] vals, boolean autoCommit) throws SQLException
```

```java
final int params = ...
```

> @see <a
> href="https://www.sqlite.org/c_interface.html#sqlite_exec">https://www.sqlite.org/c_interface.html#sqlite_exec</a>
> @param stmt Stmt object.
> @param vals Array of parameter values.
> @return True if a row of ResultSet is ready; false otherwise.
> @throws SQLException

```java
public final synchronized boolean execute(CoreStatement stmt, Object[] vals)
```

```java
final int params = ...
```

> Executes the given SQL statement using the one-step query execution interface.
>
> @param sql SQL statement to be executed.
> @return True if a row of ResultSet is ready; false otherwise.
> @throws SQLException
> @see <a
> href="https://www.sqlite.org/c3ref/exec.html">https://www.sqlite.org/c3ref/exec.html</a>

```java
final synchronized boolean execute(String sql, boolean autoCommit) throws SQLException
```

> Execute an SQL INSERT, UPDATE or DELETE statement with the Stmt object and an array of
> parameter values of the SQL statement..
>
> @param stmt Stmt object.
> @param vals Array of parameter values.
> @return Number of database rows that were changed or inserted or deleted by the most recently
> completed SQL.
> @throws SQLException

```java
public final synchronized long executeUpdate(CoreStatement stmt, Object[] vals)
```

```java
abstract void set_commit_listener(boolean enabled) ;
```

```java
abstract void set_update_listener(boolean enabled) ;
```

```java
public synchronized void addUpdateListener(SQLiteUpdateListener listener)
```

```java
public synchronized void addCommitListener(SQLiteCommitListener listener)
```

```java
public synchronized void removeUpdateListener(SQLiteUpdateListener listener)
```

```java
public synchronized void removeCommitListener(SQLiteCommitListener listener)
```

> Throws SQLException with error message.
>
> @throws SQLException

```java
final void throwex() throws SQLException
```

> Throws SQLException with error code.
>
> @param errorCode Error code to be passed.
> @throws SQLException Formatted SQLException with error code.

```java
public final void throwex(int errorCode) throws SQLException
```

> Throws SQL Exception with error code and message.
>
> @param errorCode Error code to be passed.
> @param errorMessage Error message to be passed.
> @throws SQLException Formatted SQLException with error code and message.

```java
static void throwex(int errorCode, String errorMessage) throws SQLException
```

> Throws formatted SQLException with error code and message.
>
> @param errorCode Error code to be passed.
> @param errorMessage Error message to be passed.
> @return Formatted SQLException with error code and message.

```java
public static SQLiteException newSQLException(int errorCode, String errorMessage)
```

> SQLite and the JDBC API have very different ideas about the meaning of auto-commit. Under
> JDBC, when executeUpdate() returns in auto-commit mode (the default), the programmer assumes
> the data has been written to disk. In SQLite however, a call to sqlite3_step() with an INSERT
> statement can return SQLITE_OK, and yet the data is still in limbo.
>
> <p>This limbo appears when another statement on the database is active, e.g. a SELECT. SQLite
> auto-commit waits until the final read statement finishes, and then writes whatever updates
> have already been OKed. So if a program crashes before the reads are complete, data is lost.
> E.g:
>
> <p>select begins insert select continues select finishes
>
> <p>Works as expected, however
>
> <p>select beings insert select continues crash
>
> <p>Results in the data never being written to disk.
>
> <p>As a solution, we call "commit" after every statement in auto-commit mode.
>
> @throws SQLException

```java
final void ensureAutoCommit(boolean autoCommit) throws SQLException
```

```java
public abstract byte[] serialize(String schema) throws SQLException ;
```

```java
public abstract void deserialize(String schema, byte[] buff) throws SQLException ;
```

#### `org/sqlite/core/NativeDB.java`

> This class provides a thin JNI layer over the SQLite3 C API.

```java
public final class NativeDB extends DB
```

> Loads the SQLite interface backend.
>
> @return True if the SQLite JDBC driver is successfully loaded; false otherwise.

```java
public static boolean load() throws Exception
```

```java
synchronized native void _open_utf8(byte[] fileUtf8, int openFlags) throws SQLException ;
```

> @see org.sqlite.core.DB#_exec(java.lang.String)

```java
    @Override
public synchronized int _exec(String sql) throws SQLException
```

```java
synchronized native int _exec_utf8(byte[] sqlUtf8) throws SQLException ;
```

> @see org.sqlite.core.DB#shared_cache(boolean)

```java
    @Override
public synchronized native int shared_cache(boolean enable) ;
```

> @see org.sqlite.core.DB#enable_load_extension(boolean)

```java
    @Override
public synchronized native int enable_load_extension(boolean enable) ;
```

> @see org.sqlite.core.DB#interrupt()

```java
    @Override
public native void interrupt() ;
```

> @see org.sqlite.core.DB#busy_timeout(int)

```java
    @Override
public synchronized native void busy_timeout(int ms) ;
```

> @see org.sqlite.core.DB#busy_handler(BusyHandler)

```java
    @Override
public synchronized native void busy_handler(BusyHandler busyHandler) ;
```

```java
synchronized native long prepare_utf8(byte[] sqlUtf8) throws SQLException ;
```

> @see org.sqlite.core.DB#errmsg()

```java
    @Override
synchronized String errmsg()
```

```java
synchronized native ByteBuffer errmsg_utf8() ;
```

> @see org.sqlite.core.DB#libversion()

```java
    @Override
public synchronized String libversion()
```

```java
native ByteBuffer libversion_utf8() ;
```

> @see org.sqlite.core.DB#changes()

```java
    @Override
public synchronized native long changes() ;
```

> @see org.sqlite.core.DB#total_changes()

```java
    @Override
public synchronized native long total_changes() ;
```

> @see org.sqlite.core.DB#step(long)

```java
    @Override
public synchronized native int step(long stmt) ;
```

> @see org.sqlite.core.DB#reset(long)

```java
    @Override
public synchronized native int reset(long stmt) ;
```

> @see org.sqlite.core.DB#clear_bindings(long)

```java
    @Override
public synchronized native int clear_bindings(long stmt) ;
```

> @see org.sqlite.core.DB#bind_parameter_count(long)

```java
    @Override
synchronized native int bind_parameter_count(long stmt) ;
```

> @see org.sqlite.core.DB#column_count(long)

```java
    @Override
public synchronized native int column_count(long stmt) ;
```

> @see org.sqlite.core.DB#column_type(long, int)

```java
    @Override
public synchronized native int column_type(long stmt, int col) ;
```

> @see org.sqlite.core.DB#column_decltype(long, int)

```java
    @Override
public synchronized String column_decltype(long stmt, int col)
```

```java
synchronized native ByteBuffer column_decltype_utf8(long stmt, int col) ;
```

> @see org.sqlite.core.DB#column_table_name(long, int)

```java
    @Override
public synchronized String column_table_name(long stmt, int col)
```

```java
synchronized native ByteBuffer column_table_name_utf8(long stmt, int col) ;
```

> @see org.sqlite.core.DB#column_name(long, int)

```java
    @Override
public synchronized String column_name(long stmt, int col)
```

```java
synchronized native ByteBuffer column_name_utf8(long stmt, int col) ;
```

> @see org.sqlite.core.DB#column_text(long, int)

```java
    @Override
public synchronized String column_text(long stmt, int col)
```

```java
synchronized native ByteBuffer column_text_utf8(long stmt, int col) ;
```

> @see org.sqlite.core.DB#column_blob(long, int)

```java
    @Override
public synchronized native byte[] column_blob(long stmt, int col) ;
```

> @see org.sqlite.core.DB#column_double(long, int)

```java
    @Override
public synchronized native double column_double(long stmt, int col) ;
```

> @see org.sqlite.core.DB#column_long(long, int)

```java
    @Override
public synchronized native long column_long(long stmt, int col) ;
```

> @see org.sqlite.core.DB#column_int(long, int)

```java
    @Override
public synchronized native int column_int(long stmt, int col) ;
```

> @see org.sqlite.core.DB#bind_null(long, int)

```java
    @Override
synchronized native int bind_null(long stmt, int pos) ;
```

> @see org.sqlite.core.DB#bind_int(long, int, int)

```java
    @Override
synchronized native int bind_int(long stmt, int pos, int v) ;
```

> @see org.sqlite.core.DB#bind_long(long, int, long)

```java
    @Override
synchronized native int bind_long(long stmt, int pos, long v) ;
```

> @see org.sqlite.core.DB#bind_double(long, int, double)

```java
    @Override
synchronized native int bind_double(long stmt, int pos, double v) ;
```

> @see org.sqlite.core.DB#bind_text(long, int, java.lang.String)

```java
    @Override
synchronized int bind_text(long stmt, int pos, String v)
```

```java
synchronized native int bind_text_utf8(long stmt, int pos, byte[] vUtf8) ;
```

> @see org.sqlite.core.DB#bind_blob(long, int, byte[])

```java
    @Override
synchronized native int bind_blob(long stmt, int pos, byte[] v) ;
```

> @see org.sqlite.core.DB#result_null(long)

```java
    @Override
public synchronized native void result_null(long context) ;
```

> @see org.sqlite.core.DB#result_text(long, java.lang.String)

```java
    @Override
public synchronized void result_text(long context, String val)
```

```java
synchronized native void result_text_utf8(long context, byte[] valUtf8) ;
```

> @see org.sqlite.core.DB#result_blob(long, byte[])

```java
    @Override
public synchronized native void result_blob(long context, byte[] val) ;
```

> @see org.sqlite.core.DB#result_double(long, double)

```java
    @Override
public synchronized native void result_double(long context, double val) ;
```

> @see org.sqlite.core.DB#result_long(long, long)

```java
    @Override
public synchronized native void result_long(long context, long val) ;
```

> @see org.sqlite.core.DB#result_int(long, int)

```java
    @Override
public synchronized native void result_int(long context, int val) ;
```

> @see org.sqlite.core.DB#result_error(long, java.lang.String)

```java
    @Override
public synchronized void result_error(long context, String err)
```

```java
synchronized native void result_error_utf8(long context, byte[] errUtf8) ;
```

> @see org.sqlite.core.DB#value_text(org.sqlite.Function, int)

```java
    @Override
public synchronized String value_text(Function f, int arg)
```

```java
synchronized native ByteBuffer value_text_utf8(Function f, int argUtf8) ;
```

> @see org.sqlite.core.DB#value_blob(org.sqlite.Function, int)

```java
    @Override
public synchronized native byte[] value_blob(Function f, int arg) ;
```

> @see org.sqlite.core.DB#value_double(org.sqlite.Function, int)

```java
    @Override
public synchronized native double value_double(Function f, int arg) ;
```

> @see org.sqlite.core.DB#value_long(org.sqlite.Function, int)

```java
    @Override
public synchronized native long value_long(Function f, int arg) ;
```

> @see org.sqlite.core.DB#value_int(org.sqlite.Function, int)

```java
    @Override
public synchronized native int value_int(Function f, int arg) ;
```

> @see org.sqlite.core.DB#value_type(org.sqlite.Function, int)

```java
    @Override
public synchronized native int value_type(Function f, int arg) ;
```

> @see org.sqlite.core.DB#create_function(java.lang.String, org.sqlite.Function, int, int)

```java
    @Override
public synchronized int create_function(String name, Function func, int nArgs, int flags)
```

```java
synchronized native int create_function_utf8(
            byte[] nameUtf8, Function func, int nArgs, int flags) ;
```

> @see org.sqlite.core.DB#destroy_function(java.lang.String)

```java
    @Override
public synchronized int destroy_function(String name) throws SQLException
```

```java
synchronized native int destroy_function_utf8(byte[] nameUtf8) ;
```

> @see org.sqlite.core.DB#create_collation(String, Collation)

```java
    @Override
public synchronized int create_collation(String name, Collation coll) throws SQLException
```

```java
synchronized native int create_collation_utf8(byte[] nameUtf8, Collation coll) ;
```

> @see org.sqlite.core.DB#destroy_collation(String)

```java
    @Override
public synchronized int destroy_collation(String name) throws SQLException
```

```java
synchronized native int destroy_collation_utf8(byte[] nameUtf8) ;
```

```java
    @Override
public synchronized native int limit(int id, int value) throws SQLException ;
```

```java
final byte[] nameUtf8 = ...
```

> @see org.sqlite.core.DB#backup(java.lang.String, java.lang.String,
> org.sqlite.core.DB.ProgressObserver)

```java
    @Override
public int backup(String dbName, String destFileName, ProgressObserver observer)
```

> @see org.sqlite.core.DB#backup(String, String, org.sqlite.core.DB.ProgressObserver, int, int,
> int)

```java
    @Override
public int backup(
            String dbName,
            String destFileName,
            ProgressObserver observer,
            int sleepTimeMillis,
            int nTimeouts,
            int pagesPerStep)
```

```java
synchronized native int backup(
            byte[] dbNameUtf8,
            byte[] destFileNameUtf8,
            ProgressObserver observer,
            int sleepTimeMillis,
            int nTimeouts,
            int pagesPerStep)
```

> @see org.sqlite.core.DB#restore(java.lang.String, java.lang.String,
> org.sqlite.core.DB.ProgressObserver)

```java
    @Override
public synchronized int restore(String dbName, String sourceFileName, ProgressObserver observer)
```

> @see org.sqlite.core.DB#restore(String, String, ProgressObserver, int, int, int)

```java
    @Override
public synchronized int restore(
            String dbName,
            String sourceFileName,
            ProgressObserver observer,
            int sleepTimeMillis,
            int nTimeouts,
            int pagesPerStep)
```

```java
synchronized native int restore(
            byte[] dbNameUtf8,
            byte[] sourceFileName,
            ProgressObserver observer,
            int sleepTimeMillis,
            int nTimeouts,
            int pagesPerStep)
```

> Provides metadata for table columns.
>
> @returns For each column returns: <br>
> res[col][0] = true if column constrained NOT NULL<br>
> res[col][1] = true if column is part of the primary key<br>
> res[col][2] = true if column is auto-increment.
> @see org.sqlite.core.DB#column_metadata(long)

```java
    @Override
synchronized native boolean[][] column_metadata(long stmt) ;
```

```java
    @Override
synchronized native void set_commit_listener(boolean enabled) ;
```

```java
    @Override
synchronized native void set_update_listener(boolean enabled) ;
```

> Throws an SQLException. Called from native code
>
> @param msg Message for the SQLException.
> @throws SQLException the generated SQLException

```java
static void throwex(String msg) throws SQLException
```

```java
static byte[] stringToUtf8ByteArray(String str)
```

```java
static String utf8ByteBufferToString(ByteBuffer buffer)
```

```java
public synchronized native void register_progress_handler(
            int vmCalls, ProgressHandler progressHandler) throws SQLException ;
```

```java
public synchronized native void clear_progress_handler() throws SQLException ;
```

```java
    @Override
public synchronized native byte[] serialize(String schema) throws SQLException ;
```

```java
    @Override
public synchronized native void deserialize(String schema, byte[] buff) throws SQLException ;
```

#### `org/sqlite/core/SafeStmtPtr.java`

> A class for safely wrapping calls to a native pointer to a statement, ensuring no other thread
> has access to the pointer while it is run

```java
public class SafeStmtPtr
```

> Check whether this pointer has been closed
>
> @return whether this pointer has been closed

```java
public boolean isClosed()
```

> Close this pointer
>
> @return the return code of the close callback function
> @throws SQLException if the close callback throws an SQLException, or the pointer is locked
> elsewhere

```java
public int close() throws SQLException
```

> Run a callback with the wrapped pointer safely.
>
> @param run the function to run
> @return the return of the passed in function
> @throws SQLException if the pointer is utilized elsewhere

```java
public <E extends Throwable> int safeRunInt(SafePtrIntFunction<E> run) throws SQLException, E
```

> Run a callback with the wrapped pointer safely.
>
> @param run the function to run
> @return the return of the passed in function
> @throws SQLException if the pointer is utilized elsewhere

```java
public <E extends Throwable> long safeRunLong(SafePtrLongFunction<E> run)
```

> Run a callback with the wrapped pointer safely.
>
> @param run the function to run
> @return the return of the passed in function
> @throws SQLException if the pointer is utilized elsewhere

```java
public <E extends Throwable> double safeRunDouble(SafePtrDoubleFunction<E> run)
```

> Run a callback with the wrapped pointer safely.
>
> @param run the function to run
> @return the return code of the function
> @throws SQLException if the pointer is utilized elsewhere

```java
public <T, E extends Throwable> T safeRun(SafePtrFunction<T, E> run) throws SQLException, E
```

> Run a callback with the wrapped pointer safely.
>
> @param run the function to run
> @throws SQLException if the pointer is utilized elsewhere

```java
public <E extends Throwable> void safeRunConsume(SafePtrConsumer<E> run)
```

```java
    @Override
public boolean equals(Object o)
```

```java
    @Override
public int hashCode()
```

```java
    @FunctionalInterface
public interface SafePtrIntFunction<E extends Throwable>
```

```java
    @FunctionalInterface
public interface SafePtrLongFunction<E extends Throwable>
```

```java
    @FunctionalInterface
public interface SafePtrDoubleFunction<E extends Throwable>
```

```java
    @FunctionalInterface
public interface SafePtrFunction<T, E extends Throwable>
```

```java
    @FunctionalInterface
public interface SafePtrConsumer<E extends Throwable>
```

#### `org/sqlite/date/DateFormatUtils.java`

> Date and time formatting utilities and constants.
>
> <p>Formatting is performed using the thread-safe org.apache.commons.lang3.time.FastDateFormat
> class.
>
> <p>Note that the JDK has a bug wherein calling Calendar.get(int) will override any previously
> called Calendar.clear() calls. See LANG-755.
>
> @since 2.0
> @version $Id$

```java
public class DateFormatUtils
```

> ISO 8601 formatter for date-time without time zone. The format used is {@code
> yyyy-MM-dd'T'HH:mm:ss}.

```java
public static final FastDateFormat ISO_DATETIME_FORMAT = ...
```

> ISO 8601 formatter for date-time with time zone. The format used is {@code
> yyyy-MM-dd'T'HH:mm:ssZZ}.

```java
public static final FastDateFormat ISO_DATETIME_TIME_ZONE_FORMAT = ...
```

> ISO 8601 formatter for date without time zone. The format used is {@code yyyy-MM-dd}.

```java
public static final FastDateFormat ISO_DATE_FORMAT = ...
```

> ISO 8601-like formatter for date with time zone. The format used is {@code yyyy-MM-ddZZ}.
> This pattern does not comply with the formal ISO 8601 specification as the standard does not
> allow a time zone without a time.

```java
public static final FastDateFormat ISO_DATE_TIME_ZONE_FORMAT = ...
```

> ISO 8601 formatter for time without time zone. The format used is {@code 'T'HH:mm:ss}.

```java
public static final FastDateFormat ISO_TIME_FORMAT = ...
```

> ISO 8601 formatter for time with time zone. The format used is {@code 'T'HH:mm:ssZZ}.

```java
public static final FastDateFormat ISO_TIME_TIME_ZONE_FORMAT = ...
```

> ISO 8601-like formatter for time without time zone. The format used is {@code HH:mm:ss}. This
> pattern does not comply with the formal ISO 8601 specification as the standard requires the
> 'T' prefix for times.

```java
public static final FastDateFormat ISO_TIME_NO_T_FORMAT = ...
```

> ISO 8601-like formatter for time with time zone. The format used is {@code HH:mm:ssZZ}. This
> pattern does not comply with the formal ISO 8601 specification as the standard requires the
> 'T' prefix for times.

```java
public static final FastDateFormat ISO_TIME_NO_T_TIME_ZONE_FORMAT = ...
```

> SMTP (and probably other) date headers. The format used is {@code EEE, dd MMM yyyy HH:mm:ss
> Z} in US locale.

```java
public static final FastDateFormat SMTP_DATETIME_FORMAT = ...
```

> Formats a date/time into a specific pattern using the UTC time zone.
>
> @param millis the date to format expressed in milliseconds
> @param pattern the pattern to use to format the date, not null
> @return the formatted date

```java
public static String formatUTC(final long millis, final String pattern)
```

> Formats a date/time into a specific pattern using the UTC time zone.
>
> @param date the date to format, not null
> @param pattern the pattern to use to format the date, not null
> @return the formatted date

```java
public static String formatUTC(final Date date, final String pattern)
```

> Formats a date/time into a specific pattern using the UTC time zone.
>
> @param millis the date to format expressed in milliseconds
> @param pattern the pattern to use to format the date, not null
> @param locale the locale to use, may be <code>null</code>
> @return the formatted date

```java
public static String formatUTC(final long millis, final String pattern, final Locale locale)
```

> Formats a date/time into a specific pattern using the UTC time zone.
>
> @param date the date to format, not null
> @param pattern the pattern to use to format the date, not null
> @param locale the locale to use, may be <code>null</code>
> @return the formatted date

```java
public static String formatUTC(final Date date, final String pattern, final Locale locale)
```

> Formats a date/time into a specific pattern.
>
> @param millis the date to format expressed in milliseconds
> @param pattern the pattern to use to format the date, not null
> @return the formatted date

```java
public static String format(final long millis, final String pattern)
```

> Formats a date/time into a specific pattern.
>
> @param date the date to format, not null
> @param pattern the pattern to use to format the date, not null
> @return the formatted date

```java
public static String format(final Date date, final String pattern)
```

> Formats a calendar into a specific pattern.
>
> @param calendar the calendar to format, not null
> @param pattern the pattern to use to format the calendar, not null
> @return the formatted calendar
> @see FastDateFormat#format(Calendar)
> @since 2.4

```java
public static String format(final Calendar calendar, final String pattern)
```

> Formats a date/time into a specific pattern in a time zone.
>
> @param millis the time expressed in milliseconds
> @param pattern the pattern to use to format the date, not null
> @param timeZone the time zone to use, may be <code>null</code>
> @return the formatted date

```java
public static String format(final long millis, final String pattern, final TimeZone timeZone)
```

> Formats a date/time into a specific pattern in a time zone.
>
> @param date the date to format, not null
> @param pattern the pattern to use to format the date, not null
> @param timeZone the time zone to use, may be <code>null</code>
> @return the formatted date

```java
public static String format(final Date date, final String pattern, final TimeZone timeZone)
```

> Formats a calendar into a specific pattern in a time zone.
>
> @param calendar the calendar to format, not null
> @param pattern the pattern to use to format the calendar, not null
> @param timeZone the time zone to use, may be <code>null</code>
> @return the formatted calendar
> @see FastDateFormat#format(Calendar)
> @since 2.4

```java
public static String format(
            final Calendar calendar, final String pattern, final TimeZone timeZone)
```

> Formats a date/time into a specific pattern in a locale.
>
> @param millis the date to format expressed in milliseconds
> @param pattern the pattern to use to format the date, not null
> @param locale the locale to use, may be <code>null</code>
> @return the formatted date

```java
public static String format(final long millis, final String pattern, final Locale locale)
```

> Formats a date/time into a specific pattern in a locale.
>
> @param date the date to format, not null
> @param pattern the pattern to use to format the date, not null
> @param locale the locale to use, may be <code>null</code>
> @return the formatted date

```java
public static String format(final Date date, final String pattern, final Locale locale)
```

> Formats a calendar into a specific pattern in a locale.
>
> @param calendar the calendar to format, not null
> @param pattern the pattern to use to format the calendar, not null
> @param locale the locale to use, may be <code>null</code>
> @return the formatted calendar
> @see FastDateFormat#format(Calendar)
> @since 2.4

```java
public static String format(
            final Calendar calendar, final String pattern, final Locale locale)
```

> Formats a date/time into a specific pattern in a time zone and locale.
>
> @param millis the date to format expressed in milliseconds
> @param pattern the pattern to use to format the date, not null
> @param timeZone the time zone to use, may be <code>null</code>
> @param locale the locale to use, may be <code>null</code>
> @return the formatted date

```java
public static String format(
            final long millis, final String pattern, final TimeZone timeZone, final Locale locale)
```

> Formats a date/time into a specific pattern in a time zone and locale.
>
> @param date the date to format, not null
> @param pattern the pattern to use to format the date, not null, not null
> @param timeZone the time zone to use, may be <code>null</code>
> @param locale the locale to use, may be <code>null</code>
> @return the formatted date

```java
public static String format(
            final Date date, final String pattern, final TimeZone timeZone, final Locale locale)
```

```java
final FastDateFormat df = ...
```

> Formats a calendar into a specific pattern in a time zone and locale.
>
> @param calendar the calendar to format, not null
> @param pattern the pattern to use to format the calendar, not null
> @param timeZone the time zone to use, may be <code>null</code>
> @param locale the locale to use, may be <code>null</code>
> @return the formatted calendar
> @see FastDateFormat#format(Calendar)
> @since 2.4

```java
public static String format(
            final Calendar calendar,
            final String pattern,
            final TimeZone timeZone,
            final Locale locale)
```

```java
final FastDateFormat df = ...
```

#### `org/sqlite/date/DateParser.java`

> DateParser is the "missing" interface for the parsing methods of {@link java.text.DateFormat}.
>
> @since 3.2

```java
public interface DateParser
```

#### `org/sqlite/date/DatePrinter.java`

> DatePrinter is the "missing" interface for the format methods of {@link java.text.DateFormat}.
>
> @since 3.2

```java
public interface DatePrinter
```

#### `org/sqlite/date/ExceptionUtils.java`

> Provides utilities for manipulating and examining <code>Throwable</code> objects.
>
> @since 1.0

```java
public class ExceptionUtils
```

> Throw a checked exception without adding the exception to the throws clause of the calling
> method. This method prevents throws clause pollution and reduces the clutter of "Caused by"
> exceptions in the stacktrace.
>
> <p>The use of this technique may be controversial, but exceedingly useful to library
> developers. <code>
> public int propagateExample { // note that there is no throws clause
> try {
> return invocation(); // throws IOException
> } catch (Exception e) {
> return ExceptionUtils.rethrow(e);  // propagates a checked exception
> }
> }
> </code>
>
> <p>This is an alternative to the more conservative approach of wrapping the checked exception
> in a RuntimeException: <code>
> public int wrapExample { // note that there is no throws clause
> try {
> return invocation(); // throws IOException
> } catch (Error e) {
> throw e;
> } catch (RuntimeException e) {
> throw e;  // wraps a checked exception
> } catch (Exception e) {
> throw new UndeclaredThrowableException(e);  // wraps a checked exception
> }
> }
> </code>
>
> <p>One downside to using this approach is that the java compiler will not allow invoking code
> to specify a checked exception in a catch clause unless there is some code path within the
> try block that has invoked a method declared with that checked exception. If the invoking
> site wishes to catch the shaded checked exception, it must either invoke the shaded code
> through a method re-declaring the desired checked exception, or catch Exception and use the
> instanceof operator. Either of these techniques are required when interacting with non-java
> jvm code such as Jython, Scala, or Groovy, since these languages do not consider any
> exceptions as checked.
>
> @since 3.5
> @see {{@link #wrapAndThrow(Throwable)}
> @param throwable The throwable to rethrow.
> @return R Never actually returns, this generic type matches any type which the calling site
> requires. "Returning" the results of this method, as done in the propagateExample above,
> will satisfy the java compiler requirement that all code paths return a value.
> @throws throwable

```java
public static <R> R rethrow(Throwable throwable)
```

#### `org/sqlite/date/FastDateFormat.java`

> FastDateFormat is a fast and thread-safe version of {@link java.text.SimpleDateFormat}.
>
> <p>To obtain an instance of FastDateFormat, use one of the static factory methods: {@link
> #getInstance(String, TimeZone, Locale)}, {@link #getDateInstance(int, TimeZone, Locale)}, {@link
> #getTimeInstance(int, TimeZone, Locale)}, or {@link #getDateTimeInstance(int, int, TimeZone,
> Locale)}
>
> <p>Since FastDateFormat is thread safe, you can use a static member instance: <code>
> private static final FastDateFormat DATE_FORMATTER = FastDateFormat.getDateTimeInstance(FastDateFormat.LONG, FastDateFormat.SHORT);
> </code>
>
> <p>This class can be used as a direct replacement to {@code SimpleDateFormat} in most formatting
> and parsing situations. This class is especially useful in multi-threaded server environments.
> {@code SimpleDateFormat} is not thread-safe in any JDK version, nor will it be as Sun have closed
> the bug/RFE.
>
> <p>All patterns are compatible with SimpleDateFormat (except time zones and some year patterns -
> see below).
>
> <p>Since 3.2, FastDateFormat supports parsing as well as printing.
>
> <p>Java 1.4 introduced a new pattern letter, {@code 'Z'}, to represent time zones in RFC822
> format (eg. {@code +0800} or {@code -1100}). This pattern letter can be used here (on all JDK
> versions).
>
> <p>In addition, the pattern {@code 'ZZ'} has been made to represent ISO 8601 full format time
> zones (eg. {@code +08:00} or {@code -11:00}). This introduces a minor incompatibility with Java
> 1.4, but at a gain of useful functionality.
>
> <p>Javadoc cites for the year pattern: <i>For formatting, if the number of pattern letters is 2,
> the year is truncated to 2 digits; otherwise it is interpreted as a number.</i> Starting with
> Java 1.7 a pattern of 'Y' or 'YYY' will be formatted as '2003', while it was '03' in former Java
> versions. FastDateFormat implements the behavior of Java 7.
>
> @since 2.0
> @version $Id$

```java
public class FastDateFormat extends Format implements DateParser, DatePrinter
```

> FULL locale dependent date or time style.

```java
public static final int FULL = ...
```

> LONG locale dependent date or time style.

```java
public static final int LONG = ...
```

> MEDIUM locale dependent date or time style.

```java
public static final int MEDIUM = ...
```

> SHORT locale dependent date or time style.

```java
public static final int SHORT = ...
```

> Gets a formatter instance using the default pattern in the default locale.
>
> @return a date/time formatter

```java
public static FastDateFormat getInstance()
```

> Gets a formatter instance using the specified pattern in the default locale.
>
> @param pattern {@link java.text.SimpleDateFormat} compatible pattern
> @return a pattern based date/time formatter
> @throws IllegalArgumentException if pattern is invalid

```java
public static FastDateFormat getInstance(final String pattern)
```

> Gets a formatter instance using the specified pattern and time zone.
>
> @param pattern {@link java.text.SimpleDateFormat} compatible pattern
> @param timeZone optional time zone, overrides time zone of formatted date
> @return a pattern based date/time formatter
> @throws IllegalArgumentException if pattern is invalid

```java
public static FastDateFormat getInstance(final String pattern, final TimeZone timeZone)
```

> Gets a formatter instance using the specified pattern and locale.
>
> @param pattern {@link java.text.SimpleDateFormat} compatible pattern
> @param locale optional locale, overrides system locale
> @return a pattern based date/time formatter
> @throws IllegalArgumentException if pattern is invalid

```java
public static FastDateFormat getInstance(final String pattern, final Locale locale)
```

> Gets a formatter instance using the specified pattern, time zone and locale.
>
> @param pattern {@link java.text.SimpleDateFormat} compatible pattern
> @param timeZone optional time zone, overrides time zone of formatted date
> @param locale optional locale, overrides system locale
> @return a pattern based date/time formatter
> @throws IllegalArgumentException if pattern is invalid or {@code null}

```java
public static FastDateFormat getInstance(
            final String pattern, final TimeZone timeZone, final Locale locale)
```

> Gets a date formatter instance using the specified style in the default time zone and locale.
>
> @param style date style: FULL, LONG, MEDIUM, or SHORT
> @return a localized standard date formatter
> @throws IllegalArgumentException if the Locale has no date pattern defined
> @since 2.1

```java
public static FastDateFormat getDateInstance(final int style)
```

> Gets a date formatter instance using the specified style and locale in the default time zone.
>
> @param style date style: FULL, LONG, MEDIUM, or SHORT
> @param locale optional locale, overrides system locale
> @return a localized standard date formatter
> @throws IllegalArgumentException if the Locale has no date pattern defined
> @since 2.1

```java
public static FastDateFormat getDateInstance(final int style, final Locale locale)
```

> Gets a date formatter instance using the specified style and time zone in the default locale.
>
> @param style date style: FULL, LONG, MEDIUM, or SHORT
> @param timeZone optional time zone, overrides time zone of formatted date
> @return a localized standard date formatter
> @throws IllegalArgumentException if the Locale has no date pattern defined
> @since 2.1

```java
public static FastDateFormat getDateInstance(final int style, final TimeZone timeZone)
```

> Gets a date formatter instance using the specified style, time zone and locale.
>
> @param style date style: FULL, LONG, MEDIUM, or SHORT
> @param timeZone optional time zone, overrides time zone of formatted date
> @param locale optional locale, overrides system locale
> @return a localized standard date formatter
> @throws IllegalArgumentException if the Locale has no date pattern defined

```java
public static FastDateFormat getDateInstance(
            final int style, final TimeZone timeZone, final Locale locale)
```

> Gets a time formatter instance using the specified style in the default time zone and locale.
>
> @param style time style: FULL, LONG, MEDIUM, or SHORT
> @return a localized standard time formatter
> @throws IllegalArgumentException if the Locale has no time pattern defined
> @since 2.1

```java
public static FastDateFormat getTimeInstance(final int style)
```

> Gets a time formatter instance using the specified style and locale in the default time zone.
>
> @param style time style: FULL, LONG, MEDIUM, or SHORT
> @param locale optional locale, overrides system locale
> @return a localized standard time formatter
> @throws IllegalArgumentException if the Locale has no time pattern defined
> @since 2.1

```java
public static FastDateFormat getTimeInstance(final int style, final Locale locale)
```

> Gets a time formatter instance using the specified style and time zone in the default locale.
>
> @param style time style: FULL, LONG, MEDIUM, or SHORT
> @param timeZone optional time zone, overrides time zone of formatted time
> @return a localized standard time formatter
> @throws IllegalArgumentException if the Locale has no time pattern defined
> @since 2.1

```java
public static FastDateFormat getTimeInstance(final int style, final TimeZone timeZone)
```

> Gets a time formatter instance using the specified style, time zone and locale.
>
> @param style time style: FULL, LONG, MEDIUM, or SHORT
> @param timeZone optional time zone, overrides time zone of formatted time
> @param locale optional locale, overrides system locale
> @return a localized standard time formatter
> @throws IllegalArgumentException if the Locale has no time pattern defined

```java
public static FastDateFormat getTimeInstance(
            final int style, final TimeZone timeZone, final Locale locale)
```

> Gets a date/time formatter instance using the specified style in the default time zone and
> locale.
>
> @param dateStyle date style: FULL, LONG, MEDIUM, or SHORT
> @param timeStyle time style: FULL, LONG, MEDIUM, or SHORT
> @return a localized standard date/time formatter
> @throws IllegalArgumentException if the Locale has no date/time pattern defined
> @since 2.1

```java
public static FastDateFormat getDateTimeInstance(final int dateStyle, final int timeStyle)
```

> Gets a date/time formatter instance using the specified style and locale in the default time
> zone.
>
> @param dateStyle date style: FULL, LONG, MEDIUM, or SHORT
> @param timeStyle time style: FULL, LONG, MEDIUM, or SHORT
> @param locale optional locale, overrides system locale
> @return a localized standard date/time formatter
> @throws IllegalArgumentException if the Locale has no date/time pattern defined
> @since 2.1

```java
public static FastDateFormat getDateTimeInstance(
            final int dateStyle, final int timeStyle, final Locale locale)
```

> Gets a date/time formatter instance using the specified style and time zone in the default
> locale.
>
> @param dateStyle date style: FULL, LONG, MEDIUM, or SHORT
> @param timeStyle time style: FULL, LONG, MEDIUM, or SHORT
> @param timeZone optional time zone, overrides time zone of formatted date
> @return a localized standard date/time formatter
> @throws IllegalArgumentException if the Locale has no date/time pattern defined
> @since 2.1

```java
public static FastDateFormat getDateTimeInstance(
            final int dateStyle, final int timeStyle, final TimeZone timeZone)
```

> Gets a date/time formatter instance using the specified style, time zone and locale.
>
> @param dateStyle date style: FULL, LONG, MEDIUM, or SHORT
> @param timeStyle time style: FULL, LONG, MEDIUM, or SHORT
> @param timeZone optional time zone, overrides time zone of formatted date
> @param locale optional locale, overrides system locale
> @return a localized standard date/time formatter
> @throws IllegalArgumentException if the Locale has no date/time pattern defined

```java
public static FastDateFormat getDateTimeInstance(
            final int dateStyle,
            final int timeStyle,
            final TimeZone timeZone,
            final Locale locale)
```

> Formats a {@code Date}, {@code Calendar} or {@code Long} (milliseconds) object.
>
> @param obj the object to format
> @param toAppendTo the buffer to append to
> @param pos the position - ignored
> @return the buffer passed in

```java
    @Override
public StringBuffer format(
            final Object obj, final StringBuffer toAppendTo, final FieldPosition pos)
```

> Formats a millisecond {@code long} value.
>
> @param millis the millisecond value to format
> @return the formatted string
> @since 2.1

```java
public String format(final long millis)
```

> Formats a {@code Date} object using a {@code GregorianCalendar}.
>
> @param date the date to format
> @return the formatted string

```java
public String format(final Date date)
```

> Formats a {@code Calendar} object.
>
> @param calendar the calendar to format
> @return the formatted string

```java
public String format(final Calendar calendar)
```

> Formats a millisecond {@code long} value into the supplied {@code StringBuffer}.
>
> @param millis the millisecond value to format
> @param buf the buffer to format into
> @return the specified string buffer
> @since 2.1

```java
public StringBuffer format(final long millis, final StringBuffer buf)
```

> Formats a {@code Date} object into the supplied {@code StringBuffer} using a {@code
> GregorianCalendar}.
>
> @param date the date to format
> @param buf the buffer to format into
> @return the specified string buffer

```java
public StringBuffer format(final Date date, final StringBuffer buf)
```

> Formats a {@code Calendar} object into the supplied {@code StringBuffer}.
>
> @param calendar the calendar to format
> @param buf the buffer to format into
> @return the specified string buffer

```java
public StringBuffer format(final Calendar calendar, final StringBuffer buf)
```

```java
public Date parse(final String source) throws ParseException
```

```java
public Date parse(final String source, final ParsePosition pos)
```

```java
public Object parseObject(final String source, final ParsePosition pos)
```

> Gets the pattern used by this formatter.
>
> @return the pattern, {@link java.text.SimpleDateFormat} compatible

```java
public String getPattern()
```

> Gets the time zone used by this formatter.
>
> <p>This zone is always used for {@code Date} formatting.
>
> @return the time zone

```java
public TimeZone getTimeZone()
```

> Gets the locale used by this formatter.
>
> @return the locale

```java
public Locale getLocale()
```

> Gets an estimate for the maximum string length that the formatter will produce.
>
> <p>The actual formatted length will almost always be less than or equal to this amount.
>
> @return the maximum formatted length

```java
public int getMaxLengthEstimate()
```

> Compares two objects for equality.
>
> @param obj the object to compare to
> @return {@code true} if equal

```java
    @Override
public boolean equals(final Object obj)
```

```java
final FastDateFormat other = ...
```

> Returns a hashcode compatible with equals.
>
> @return a hashcode compatible with equals

```java
    @Override
public int hashCode()
```

> Gets a debugging string version of this formatter.
>
> @return a debugging string

```java
    @Override
public String toString()
```

#### `org/sqlite/date/FastDateParser.java`

> FastDateParser is a fast and thread-safe version of {@link java.text.SimpleDateFormat}.
>
> <p>To obtain a proxy to a FastDateParser, use {@link FastDateFormat#getInstance(String, TimeZone,
> Locale)} or another variation of the factory methods of {@link FastDateFormat}.
>
> <p>Since FastDateParser is thread safe, you can use a static member instance: <code>
> private static final DateParser DATE_PARSER = FastDateFormat.getInstance("yyyy-MM-dd");
> </code>
>
> <p>This class can be used as a direct replacement for <code>SimpleDateFormat</code> in most
> parsing situations. This class is especially useful in multi-threaded server environments. <code>
> SimpleDateFormat</code> is not thread-safe in any JDK version, nor will it be as Sun has closed
> the <a href="http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=4228335">bug</a>/RFE.
>
> <p>Only parsing is supported by this class, but all patterns are compatible with
> SimpleDateFormat.
>
> <p>The class operates in lenient mode, so for example a time of 90 minutes is treated as 1 hour
> 30 minutes.
>
> <p>Timing tests indicate this class is as about as fast as SimpleDateFormat in single thread
> applications and about 25% faster in multi-thread applications.
>
> @version $Id$
> @since 3.2
> @see FastDatePrinter

```java
public class FastDateParser implements DateParser, Serializable
```

```java
static final Locale JAPANESE_IMPERIAL = ...
```

```java
final Calendar definingCalendar = ...
```

```java
final StringBuilder regex = ...
```

```java
final List<Strategy> collector = ...
```

```java
final Matcher patternMatcher = ...
```

```java
final String nextFormatField = ...
```

```java
public String getPattern()
```

```java
public TimeZone getTimeZone()
```

```java
public Locale getLocale()
```

> Compare another object for equality with this object.
>
> @param obj the object to compare to
> @return <code>true</code>if equal to this instance

```java
    @Override
public boolean equals(final Object obj)
```

```java
final FastDateParser other = ...
```

> Return a hashcode compatible with equals.
>
> @return a hashcode compatible with equals

```java
    @Override
public int hashCode()
```

> Get a string version of this formatter.
>
> @return a debugging string

```java
    @Override
public String toString()
```

```java
final Calendar definingCalendar = ...
```

```java
public Object parseObject(final String source) throws ParseException
```

```java
public Date parse(final String source) throws ParseException
```

```java
final Date date = ...
```

```java
public Object parseObject(final String source, final ParsePosition pos)
```

> This implementation updates the ParsePosition if the parse succeeds. However, unlike the
> method {@link java.text.SimpleDateFormat#parse(String, ParsePosition)} it is not able to set
> the error Index - i.e. {@link ParsePosition#getErrorIndex()} - if the parse fails.
>
> <p>To determine if the parse has succeeded, the caller must check if the current parse
> position given by {@link ParsePosition#getIndex()} has been updated. If the input buffer has
> been fully parsed, then the index will point to just after the end of the input buffer.
>
> <p>See org.apache.commons.lang3.time.DateParser#parse(java.lang.String,
> java.text.ParsePosition) {@inheritDoc}

```java
public Date parse(final String source, final ParsePosition pos)
```

```java
final int offset = ...
```

```java
final Matcher matcher = ...
```

```java
final Calendar cal = ...
```

```java
final Strategy strategy = ...
```

```java
final int trial = ...
```

> Generate a <code>Pattern</code> regular expression to the <code>StringBuilder</code>
> which will accept this field
>
> @param parser The parser calling this strategy
> @param regex The <code>StringBuilder</code> to append to
> @return true, if this field will set the calendar; false, if this field is a constant
> value

```java
abstract boolean addRegex(FastDateParser parser, StringBuilder regex) ;
```

```java
final ConcurrentMap<Locale, Strategy> cache = ...
```

```java
final Strategy inCache = ...
```

```java
final Map<String, Integer> keyValues = ...
```

```java
final Integer iVal = ...
```

```java
final StringBuilder sb = ...
```

```java
final String[][] zones = ...
```

```java
final TimeZone tz = ...
```

```java
final StringBuilder sb = ...
```

> Factory method for ISO8601TimeZoneStrategies.
>
> @param tokenLen a token indicating the length of the TimeZone String to be formatted.
> @return a ISO8601TimeZoneStrategy that can format TimeZone String of length {@code
> tokenLen}. If no such strategy exists, an IllegalArgumentException will be thrown.

```java
static Strategy getStrategy(int tokenLen)
```

#### `org/sqlite/date/FastDatePrinter.java`

> FastDatePrinter is a fast and thread-safe version of {@link java.text.SimpleDateFormat}.
>
> <p>To obtain a FastDatePrinter, use {@link FastDateFormat#getInstance(String, TimeZone, Locale)}
> or another variation of the factory methods of {@link FastDateFormat}.
>
> <p>Since FastDatePrinter is thread safe, you can use a static member instance: <code>
> private static final DatePrinter DATE_PRINTER = FastDateFormat.getInstance("yyyy-MM-dd");
> </code>
>
> <p>This class can be used as a direct replacement to {@code SimpleDateFormat} in most formatting
> situations. This class is especially useful in multi-threaded server environments. {@code
> SimpleDateFormat} is not thread-safe in any JDK version, nor will it be as Sun have closed the
> bug/RFE.
>
> <p>Only formatting is supported by this class, but all patterns are compatible with
> SimpleDateFormat (except time zones and some year patterns - see below).
>
> <p>Java 1.4 introduced a new pattern letter, {@code 'Z'}, to represent time zones in RFC822
> format (eg. {@code +0800} or {@code -1100}). This pattern letter can be used here (on all JDK
> versions).
>
> <p>In addition, the pattern {@code 'ZZ'} has been made to represent ISO 8601 full format time
> zones (eg. {@code +08:00} or {@code -11:00}). This introduces a minor incompatibility with Java
> 1.4, but at a gain of useful functionality.
>
> <p>Starting with JDK7, ISO 8601 support was added using the pattern {@code 'X'}. To maintain
> compatibility, {@code 'ZZ'} will continue to be supported, but using one of the {@code 'X'}
> formats is recommended.
>
> <p>Javadoc cites for the year pattern: <i>For formatting, if the number of pattern letters is 2,
> the year is truncated to 2 digits; otherwise it is interpreted as a number.</i> Starting with
> Java 1.7 a pattern of 'Y' or 'YYY' will be formatted as '2003', while it was '03' in former Java
> versions. FastDatePrinter implements the behavior of Java 7.
>
> @version $Id$
> @since 3.2
> @see FastDateParser

```java
public class FastDatePrinter implements DatePrinter, Serializable
```

> FULL locale dependent date or time style.

```java
public static final int FULL = ...
```

> LONG locale dependent date or time style.

```java
public static final int LONG = ...
```

> MEDIUM locale dependent date or time style.

```java
public static final int MEDIUM = ...
```

> SHORT locale dependent date or time style.

```java
public static final int SHORT = ...
```

```java
final List<Rule> rulesList = ...
```

```java
final DateFormatSymbols symbols = ...
```

```java
final List<Rule> rules = ...
```

```java
final String[] ERAs = ...
```

```java
final String[] months = ...
```

```java
final String[] shortMonths = ...
```

```java
final String[] weekdays = ...
```

```java
final String[] shortWeekdays = ...
```

```java
final String[] AmPmStrings = ...
```

```java
final int length = ...
```

```java
final int[] indexRef = ...
```

```java
final String token = ...
```

```java
final int tokenLen = ...
```

```java
final char c = ...
```

```java
final String sub = ...
```

```java
final StringBuilder buf = ...
```

```java
final int length = ...
```

```java
final char peek = ...
```

> Formats a {@code Date}, {@code Calendar} or {@code Long} (milliseconds) object.
>
> @param obj the object to format
> @param toAppendTo the buffer to append to
> @param pos the position - ignored
> @return the buffer passed in

```java
public StringBuffer format(
            final Object obj, final StringBuffer toAppendTo, final FieldPosition pos)
```

```java
public String format(final long millis)
```

```java
final Calendar c = ...
```

```java
public String format(final Date date)
```

```java
final Calendar c = ...
```

```java
public String format(final Calendar calendar)
```

```java
public StringBuffer format(final long millis, final StringBuffer buf)
```

```java
public StringBuffer format(final Date date, final StringBuffer buf)
```

```java
final Calendar c = ...
```

```java
public StringBuffer format(final Calendar calendar, final StringBuffer buf)
```

```java
public String getPattern()
```

```java
public TimeZone getTimeZone()
```

```java
public Locale getLocale()
```

> Gets an estimate for the maximum string length that the formatter will produce.
>
> <p>The actual formatted length will almost always be less than or equal to this amount.
>
> @return the maximum formatted length

```java
public int getMaxLengthEstimate()
```

> Compares two objects for equality.
>
> @param obj the object to compare to
> @return {@code true} if equal

```java
    @Override
public boolean equals(final Object obj)
```

```java
final FastDatePrinter other = ...
```

> Returns a hashcode compatible with equals.
>
> @return a hashcode compatible with equals

```java
    @Override
public int hashCode()
```

> Gets a debugging string version of this formatter.
>
> @return a debugging string

```java
    @Override
public String toString()
```

> {@inheritDoc}

```java
public int estimateLength()
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

> {@inheritDoc}

```java
public int estimateLength()
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

> {@inheritDoc}

```java
public int estimateLength()
```

```java
final int len = ...
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

> {@inheritDoc}

```java
public int estimateLength()
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

> {@inheritDoc}

```java
public final void appendTo(final StringBuffer buffer, final int value)
```

```java
static final UnpaddedMonthField INSTANCE = ...
```

> {@inheritDoc}

```java
public int estimateLength()
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

> {@inheritDoc}

```java
public final void appendTo(final StringBuffer buffer, final int value)
```

> {@inheritDoc}

```java
public int estimateLength()
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

> {@inheritDoc}

```java
public final void appendTo(final StringBuffer buffer, int value)
```

> {@inheritDoc}

```java
public int estimateLength()
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

> {@inheritDoc}

```java
public final void appendTo(final StringBuffer buffer, final int value)
```

```java
static final TwoDigitYearField INSTANCE = ...
```

> {@inheritDoc}

```java
public int estimateLength()
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

> {@inheritDoc}

```java
public final void appendTo(final StringBuffer buffer, final int value)
```

```java
static final TwoDigitMonthField INSTANCE = ...
```

> {@inheritDoc}

```java
public int estimateLength()
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

> {@inheritDoc}

```java
public final void appendTo(final StringBuffer buffer, final int value)
```

> {@inheritDoc}

```java
public int estimateLength()
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final int value)
```

> {@inheritDoc}

```java
public int estimateLength()
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final int value)
```

> Gets the time zone display name, using a cache for performance.
>
> @param tz the zone to query
> @param daylight true if daylight savings
> @param style the style to use {@code TimeZone.LONG} or {@code TimeZone.SHORT}
> @param locale the locale to use
> @return the textual name of the time zone

```java
static String getTimeZoneDisplay(
            final TimeZone tz, final boolean daylight, final int style, final Locale locale)
```

```java
final TimeZoneDisplayKey key = ...
```

```java
final String prior = ...
```

> {@inheritDoc}

```java
public int estimateLength()
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

```java
final TimeZone zone = ...
```

```java
static final TimeZoneNumberRule INSTANCE_COLON = ...
```

```java
static final TimeZoneNumberRule INSTANCE_NO_COLON = ...
```

```java
static final TimeZoneNumberRule INSTANCE_ISO_8601 = ...
```

```java
final boolean mColon ;
```

```java
final boolean mISO8601 ;
```

> {@inheritDoc}

```java
public int estimateLength()
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

```java
final int hours = ...
```

```java
final int minutes = ...
```

```java
static final Iso8601_Rule ISO8601_HOURS = ...
```

```java
static final Iso8601_Rule ISO8601_HOURS_MINUTES = ...
```

```java
static final Iso8601_Rule ISO8601_HOURS_COLON_MINUTES = ...
```

> Factory method for Iso8601_Rules.
>
> @param tokenLen a token indicating the length of the TimeZone String to be formatted.
> @return a Iso8601_Rule that can format TimeZone String of length {@code tokenLen}. If no
> such rule exists, an IllegalArgumentException will be thrown.

```java
static Iso8601_Rule getRule(int tokenLen)
```

```java
final int length ;
```

> {@inheritDoc}

```java
public int estimateLength()
```

> {@inheritDoc}

```java
public void appendTo(final StringBuffer buffer, final Calendar calendar)
```

```java
final int hours = ...
```

```java
final int minutes = ...
```

> {@inheritDoc}

```java
        @Override
public int hashCode()
```

> {@inheritDoc}

```java
        @Override
public boolean equals(final Object obj)
```

```java
final TimeZoneDisplayKey other = ...
```

#### `org/sqlite/date/FormatCache.java`

> FormatCache is a cache and factory for {@link Format}s.
>
> @since 3.0
> @version $Id: FormatCache 892161 2009-12-18 07:21:10Z $

```java
abstract class FormatCache<F extends Format>
```

> No date or no time. Used in same parameters as DateFormat.SHORT or DateFormat.LONG

```java
static final int NONE = ...
```

> Gets a formatter instance using the default pattern in the default timezone and locale.
>
> @return a date/time formatter

```java
public F getInstance()
```

> Gets a formatter instance using the specified pattern, time zone and locale.
>
> @param pattern {@link java.text.SimpleDateFormat} compatible pattern, non-null
> @param timeZone the time zone, null means use the default TimeZone
> @param locale the locale, null means use the default Locale
> @return a pattern based date/time formatter
> @throws IllegalArgumentException if pattern is invalid or <code>null</code>

```java
public F getInstance(final String pattern, TimeZone timeZone, Locale locale)
```

```java
final MultipartKey key = ...
```

```java
final F previousValue = ...
```

```java
final String pattern = ...
```

> Gets a date/time format for the specified styles and locale.
>
> @param dateStyle date style: FULL, LONG, MEDIUM, or SHORT, null indicates no date in format
> @param timeStyle time style: FULL, LONG, MEDIUM, or SHORT, null indicates no time in format
> @param locale The non-null locale of the desired format
> @return a localized standard date/time format
> @throws IllegalArgumentException if the Locale has no date/time pattern defined

```java
static String getPatternForStyle(
            final Integer dateStyle, final Integer timeStyle, final Locale locale)
```

```java
final MultipartKey key = ...
```

```java
final String previous = ...
```

> {@inheritDoc}

```java
        @Override
public boolean equals(final Object obj)
```

> {@inheritDoc}

```java
        @Override
public int hashCode()
```

#### `org/sqlite/javax/SQLiteConnectionPoolDataSource.java`

```java
public class SQLiteConnectionPoolDataSource extends SQLiteDataSource
        implements javax.sql.ConnectionPoolDataSource
```

> @see javax.sql.ConnectionPoolDataSource#getPooledConnection()

```java
public PooledConnection getPooledConnection() throws SQLException
```

> @see javax.sql.ConnectionPoolDataSource#getPooledConnection(java.lang.String,
> java.lang.String)

```java
public PooledConnection getPooledConnection(String user, String password) throws SQLException
```

#### `org/sqlite/javax/SQLitePooledConnection.java`

```java
public class SQLitePooledConnection extends JDBC4PooledConnection
```

```java
public SQLiteConnection getPhysicalConn()
```

> @see javax.sql.PooledConnection#close()

```java
public void close() throws SQLException
```

> @see javax.sql.PooledConnection#getConnection()

```java
public Connection getConnection() throws SQLException
```

```java
public Object invoke(Object proxy, Method method, Object[] args)
```

> @see javax.sql.PooledConnection#addConnectionEventListener(javax.sql.ConnectionEventListener)

```java
public void addConnectionEventListener(ConnectionEventListener listener)
```

> @see
> javax.sql.PooledConnection#removeConnectionEventListener(javax.sql.ConnectionEventListener)

```java
public void removeConnectionEventListener(ConnectionEventListener listener)
```

```java
public List<ConnectionEventListener> getListeners()
```

```java
    @Override
public Statement createStatement() throws SQLException
```

```java
    @Override
public PreparedStatement prepareStatement(String sql) throws SQLException
```

```java
    @Override
public CallableStatement prepareCall(String sql) throws SQLException
```

```java
    @Override
public String nativeSQL(String sql) throws SQLException
```

```java
    @Override
public void setAutoCommit(boolean autoCommit) throws SQLException
```

```java
    @Override
public boolean getAutoCommit() throws SQLException
```

```java
    @Override
public void commit() throws SQLException
```

```java
    @Override
public void rollback() throws SQLException
```

```java
    @Override
public void close() throws SQLException
```

```java
    @Override
public boolean isClosed()
```

```java
    @Override
public DatabaseMetaData getMetaData() throws SQLException
```

```java
    @Override
public void setReadOnly(boolean readOnly) throws SQLException
```

```java
    @Override
public boolean isReadOnly() throws SQLException
```

```java
    @Override
public void setCatalog(String catalog) throws SQLException
```

```java
    @Override
public String getCatalog() throws SQLException
```

```java
    @Override
public void setTransactionIsolation(int level) throws SQLException
```

```java
    @Override
public int getTransactionIsolation()
```

```java
    @Override
public SQLWarning getWarnings() throws SQLException
```

```java
    @Override
public void clearWarnings() throws SQLException
```

```java
    @Override
public Statement createStatement(int resultSetType, int resultSetConcurrency)
```

```java
    @Override
public PreparedStatement prepareStatement(
            String sql, int resultSetType, int resultSetConcurrency) throws SQLException
```

```java
    @Override
public CallableStatement prepareCall(String sql, int resultSetType, int resultSetConcurrency)
```

```java
    @Override
public Map<String, Class<?>> getTypeMap() throws SQLException
```

```java
    @Override
public void setTypeMap(Map<String, Class<?>> map) throws SQLException
```

```java
    @Override
public void setHoldability(int holdability) throws SQLException
```

```java
    @Override
public int getHoldability() throws SQLException
```

```java
    @Override
public Savepoint setSavepoint() throws SQLException
```

```java
    @Override
public Savepoint setSavepoint(String name) throws SQLException
```

```java
    @Override
public void rollback(Savepoint savepoint) throws SQLException
```

```java
    @Override
public void releaseSavepoint(Savepoint savepoint) throws SQLException
```

```java
    @Override
public Statement createStatement(
            int resultSetType, int resultSetConcurrency, int resultSetHoldability)
```

```java
    @Override
public PreparedStatement prepareStatement(
            String sql, int resultSetType, int resultSetConcurrency, int resultSetHoldability)
```

```java
    @Override
public CallableStatement prepareCall(
            String sql, int resultSetType, int resultSetConcurrency, int resultSetHoldability)
```

```java
    @Override
public PreparedStatement prepareStatement(String sql, int autoGeneratedKeys)
```

```java
    @Override
public PreparedStatement prepareStatement(String sql, int[] columnIndexes) throws SQLException
```

```java
    @Override
public PreparedStatement prepareStatement(String sql, String[] columnNames)
```

```java
    @Override
public Clob createClob() throws SQLException
```

```java
    @Override
public Blob createBlob() throws SQLException
```

```java
    @Override
public NClob createNClob() throws SQLException
```

```java
    @Override
public SQLXML createSQLXML() throws SQLException
```

```java
    @Override
public boolean isValid(int timeout) throws SQLException
```

```java
    @Override
public void setClientInfo(String name, String value) throws SQLClientInfoException
```

```java
    @Override
public void setClientInfo(Properties properties) throws SQLClientInfoException
```

```java
    @Override
public String getClientInfo(String name) throws SQLException
```

```java
    @Override
public Properties getClientInfo() throws SQLException
```

```java
    @Override
public Array createArrayOf(String typeName, Object[] elements) throws SQLException
```

```java
    @Override
public Struct createStruct(String typeName, Object[] attributes) throws SQLException
```

```java
    @Override
public void setSchema(String schema) throws SQLException
```

```java
    @Override
public String getSchema() throws SQLException
```

```java
    @Override
public void abort(Executor executor) throws SQLException
```

```java
    @Override
public void setNetworkTimeout(Executor executor, int milliseconds) throws SQLException
```

```java
    @Override
public int getNetworkTimeout() throws SQLException
```

```java
    @Override
public <T> T unwrap(Class<T> iface) throws SQLException
```

```java
    @Override
public boolean isWrapperFor(Class<?> iface) throws SQLException
```

```java
    @Override
public int getBusyTimeout()
```

```java
    @Override
public void setBusyTimeout(int timeoutMillis)
```

```java
    @Override
public DB getDatabase()
```

#### `org/sqlite/jdbc3/JDBC3Connection.java`

```java
public abstract class JDBC3Connection extends SQLiteConnection
```

> This will try to enforce the transaction mode if SQLiteConfig#isExplicitReadOnly is true and
> auto commit is disabled.
>
> <ul>
> <li>If this connection is read only, the PRAGMA query_only will be set
> <li>If this connection is not read only:
> <ul>
> <li>if no statement has been executed, PRAGMA query_only will be set to false, and an
> IMMEDIATE transaction will be started
> <li>if a statement has already been executed, an exception is thrown
> </ul>
> </ul>
>
> @throws SQLException if a statement has already been executed on this connection, then the
> transaction cannot be upgraded to write

```java
    @SuppressWarnings("deprecation")
public void tryEnforceTransactionMode() throws SQLException
```

> @see java.sql.Connection#getCatalog()

```java
public String getCatalog() throws SQLException
```

> @see java.sql.Connection#setCatalog(java.lang.String)

```java
public void setCatalog(String catalog) throws SQLException
```

> @see java.sql.Connection#getHoldability()

```java
public int getHoldability() throws SQLException
```

> @see java.sql.Connection#setHoldability(int)

```java
public void setHoldability(int h) throws SQLException
```

> @see java.sql.Connection#getTypeMap()

```java
public Map<String, Class<?>> getTypeMap() throws SQLException
```

> @see java.sql.Connection#setTypeMap(java.util.Map)

```java
public void setTypeMap(Map map) throws SQLException
```

> @see java.sql.Connection#isReadOnly()

```java
public boolean isReadOnly()
```

> @see java.sql.Connection#setReadOnly(boolean)

```java
public void setReadOnly(boolean ro) throws SQLException
```

> @see java.sql.Connection#nativeSQL(java.lang.String)

```java
public String nativeSQL(String sql)
```

> @see java.sql.Connection#clearWarnings()

```java
public void clearWarnings() throws SQLException
```

> @see java.sql.Connection#getWarnings()

```java
public SQLWarning getWarnings() throws SQLException
```

> @see java.sql.Connection#createStatement()

```java
public Statement createStatement() throws SQLException
```

> @see java.sql.Connection#createStatement(int, int)

```java
public Statement createStatement(int rsType, int rsConcurr) throws SQLException
```

> @see java.sql.Connection#createStatement(int, int, int)

```java
public abstract Statement createStatement(int rst, int rsc, int rsh) throws SQLException ;
```

> @see java.sql.Connection#prepareCall(java.lang.String)

```java
public CallableStatement prepareCall(String sql) throws SQLException
```

> @see java.sql.Connection#prepareCall(java.lang.String, int, int)

```java
public CallableStatement prepareCall(String sql, int rst, int rsc) throws SQLException
```

> @see java.sql.Connection#prepareCall(java.lang.String, int, int, int)

```java
public CallableStatement prepareCall(String sql, int rst, int rsc, int rsh)
```

> @see java.sql.Connection#prepareStatement(java.lang.String)

```java
public PreparedStatement prepareStatement(String sql) throws SQLException
```

> @see java.sql.Connection#prepareStatement(java.lang.String, int)

```java
public PreparedStatement prepareStatement(String sql, int autoC) throws SQLException
```

> @see java.sql.Connection#prepareStatement(java.lang.String, int[])

```java
public PreparedStatement prepareStatement(String sql, int[] colInds) throws SQLException
```

> @see java.sql.Connection#prepareStatement(java.lang.String, java.lang.String[])

```java
public PreparedStatement prepareStatement(String sql, String[] colNames) throws SQLException
```

> @see java.sql.Connection#prepareStatement(java.lang.String, int, int)

```java
public PreparedStatement prepareStatement(String sql, int rst, int rsc) throws SQLException
```

> @see java.sql.Connection#prepareStatement(java.lang.String, int, int, int)

```java
public abstract PreparedStatement prepareStatement(String sql, int rst, int rsc, int rsh)
```

> @see java.sql.Connection#setSavepoint()

```java
public Savepoint setSavepoint() throws SQLException
```

> @see java.sql.Connection#setSavepoint(java.lang.String)

```java
public Savepoint setSavepoint(String name) throws SQLException
```

> @see java.sql.Connection#releaseSavepoint(java.sql.Savepoint)

```java
public void releaseSavepoint(Savepoint savepoint) throws SQLException
```

> @see java.sql.Connection#rollback(java.sql.Savepoint)

```java
public void rollback(Savepoint savepoint) throws SQLException
```

```java
public Struct createStruct(String t, Object[] attr) throws SQLException
```

#### `org/sqlite/jdbc3/JDBC3DatabaseMetaData.java`

```java
public abstract class JDBC3DatabaseMetaData extends CoreDatabaseMetaData
```

```java
final Properties sqliteJdbcProp = ...
```

> @see java.sql.DatabaseMetaData#getConnection()

```java
public Connection getConnection()
```

> @see java.sql.DatabaseMetaData#getDatabaseMajorVersion()

```java
public int getDatabaseMajorVersion() throws SQLException
```

> @see java.sql.DatabaseMetaData#getDatabaseMinorVersion()

```java
public int getDatabaseMinorVersion() throws SQLException
```

> @see java.sql.DatabaseMetaData#getDriverMajorVersion()

```java
public int getDriverMajorVersion()
```

> @see java.sql.DatabaseMetaData#getDriverMinorVersion()

```java
public int getDriverMinorVersion()
```

> @see java.sql.DatabaseMetaData#getJDBCMajorVersion()

```java
public int getJDBCMajorVersion()
```

> @see java.sql.DatabaseMetaData#getJDBCMinorVersion()

```java
public int getJDBCMinorVersion()
```

> @see java.sql.DatabaseMetaData#getDefaultTransactionIsolation()

```java
public int getDefaultTransactionIsolation()
```

> @see java.sql.DatabaseMetaData#getMaxBinaryLiteralLength()

```java
public int getMaxBinaryLiteralLength()
```

> @see java.sql.DatabaseMetaData#getMaxCatalogNameLength()

```java
public int getMaxCatalogNameLength()
```

> @see java.sql.DatabaseMetaData#getMaxCharLiteralLength()

```java
public int getMaxCharLiteralLength()
```

> @see java.sql.DatabaseMetaData#getMaxColumnNameLength()

```java
public int getMaxColumnNameLength()
```

> @see java.sql.DatabaseMetaData#getMaxColumnsInGroupBy()

```java
public int getMaxColumnsInGroupBy()
```

> @see java.sql.DatabaseMetaData#getMaxColumnsInIndex()

```java
public int getMaxColumnsInIndex()
```

> @see java.sql.DatabaseMetaData#getMaxColumnsInOrderBy()

```java
public int getMaxColumnsInOrderBy()
```

> @see java.sql.DatabaseMetaData#getMaxColumnsInSelect()

```java
public int getMaxColumnsInSelect()
```

> @see java.sql.DatabaseMetaData#getMaxColumnsInTable()

```java
public int getMaxColumnsInTable()
```

> @see java.sql.DatabaseMetaData#getMaxConnections()

```java
public int getMaxConnections()
```

> @see java.sql.DatabaseMetaData#getMaxCursorNameLength()

```java
public int getMaxCursorNameLength()
```

> @see java.sql.DatabaseMetaData#getMaxIndexLength()

```java
public int getMaxIndexLength()
```

> @see java.sql.DatabaseMetaData#getMaxProcedureNameLength()

```java
public int getMaxProcedureNameLength()
```

> @see java.sql.DatabaseMetaData#getMaxRowSize()

```java
public int getMaxRowSize()
```

> @see java.sql.DatabaseMetaData#getMaxSchemaNameLength()

```java
public int getMaxSchemaNameLength()
```

> @see java.sql.DatabaseMetaData#getMaxStatementLength()

```java
public int getMaxStatementLength()
```

> @see java.sql.DatabaseMetaData#getMaxStatements()

```java
public int getMaxStatements()
```

> @see java.sql.DatabaseMetaData#getMaxTableNameLength()

```java
public int getMaxTableNameLength()
```

> @see java.sql.DatabaseMetaData#getMaxTablesInSelect()

```java
public int getMaxTablesInSelect()
```

> @see java.sql.DatabaseMetaData#getMaxUserNameLength()

```java
public int getMaxUserNameLength()
```

> @see java.sql.DatabaseMetaData#getResultSetHoldability()

```java
public int getResultSetHoldability()
```

> @see java.sql.DatabaseMetaData#getSQLStateType()

```java
public int getSQLStateType()
```

> @see java.sql.DatabaseMetaData#getDatabaseProductName()

```java
public String getDatabaseProductName()
```

> @see java.sql.DatabaseMetaData#getDatabaseProductVersion()

```java
public String getDatabaseProductVersion() throws SQLException
```

> @see java.sql.DatabaseMetaData#getDriverName()

```java
public String getDriverName()
```

> @see java.sql.DatabaseMetaData#getDriverVersion()

```java
public String getDriverVersion()
```

> @see java.sql.DatabaseMetaData#getExtraNameCharacters()

```java
public String getExtraNameCharacters()
```

> @see java.sql.DatabaseMetaData#getCatalogSeparator()

```java
public String getCatalogSeparator()
```

> @see java.sql.DatabaseMetaData#getCatalogTerm()

```java
public String getCatalogTerm()
```

> @see java.sql.DatabaseMetaData#getSchemaTerm()

```java
public String getSchemaTerm()
```

> @see java.sql.DatabaseMetaData#getProcedureTerm()

```java
public String getProcedureTerm()
```

> @see java.sql.DatabaseMetaData#getSearchStringEscape()

```java
public String getSearchStringEscape()
```

> @see java.sql.DatabaseMetaData#getIdentifierQuoteString()

```java
public String getIdentifierQuoteString()
```

> @see java.sql.DatabaseMetaData#getSQLKeywords()
> @see <a href="https://www.sqlite.org/lang_keywords.html">SQLite Keywords</a>

```java
public String getSQLKeywords()
```

> @see java.sql.DatabaseMetaData#getNumericFunctions()

```java
public String getNumericFunctions()
```

> @see java.sql.DatabaseMetaData#getStringFunctions()

```java
public String getStringFunctions()
```

> @see java.sql.DatabaseMetaData#getSystemFunctions()

```java
public String getSystemFunctions()
```

> @see java.sql.DatabaseMetaData#getTimeDateFunctions()

```java
public String getTimeDateFunctions()
```

> @see java.sql.DatabaseMetaData#getURL()

```java
public String getURL()
```

> @see java.sql.DatabaseMetaData#getUserName()

```java
public String getUserName()
```

> @see java.sql.DatabaseMetaData#allProceduresAreCallable()

```java
public boolean allProceduresAreCallable()
```

> @see java.sql.DatabaseMetaData#allTablesAreSelectable()

```java
public boolean allTablesAreSelectable()
```

> @see java.sql.DatabaseMetaData#dataDefinitionCausesTransactionCommit()

```java
public boolean dataDefinitionCausesTransactionCommit()
```

> @see java.sql.DatabaseMetaData#dataDefinitionIgnoredInTransactions()

```java
public boolean dataDefinitionIgnoredInTransactions()
```

> @see java.sql.DatabaseMetaData#doesMaxRowSizeIncludeBlobs()

```java
public boolean doesMaxRowSizeIncludeBlobs()
```

> @see java.sql.DatabaseMetaData#deletesAreDetected(int)

```java
public boolean deletesAreDetected(int type)
```

> @see java.sql.DatabaseMetaData#insertsAreDetected(int)

```java
public boolean insertsAreDetected(int type)
```

> @see java.sql.DatabaseMetaData#isCatalogAtStart()

```java
public boolean isCatalogAtStart()
```

> @see java.sql.DatabaseMetaData#locatorsUpdateCopy()

```java
public boolean locatorsUpdateCopy()
```

> @see java.sql.DatabaseMetaData#nullPlusNonNullIsNull()

```java
public boolean nullPlusNonNullIsNull()
```

> @see java.sql.DatabaseMetaData#nullsAreSortedAtEnd()

```java
public boolean nullsAreSortedAtEnd()
```

> @see java.sql.DatabaseMetaData#nullsAreSortedAtStart()

```java
public boolean nullsAreSortedAtStart()
```

> @see java.sql.DatabaseMetaData#nullsAreSortedHigh()

```java
public boolean nullsAreSortedHigh()
```

> @see java.sql.DatabaseMetaData#nullsAreSortedLow()

```java
public boolean nullsAreSortedLow()
```

> @see java.sql.DatabaseMetaData#othersDeletesAreVisible(int)

```java
public boolean othersDeletesAreVisible(int type)
```

> @see java.sql.DatabaseMetaData#othersInsertsAreVisible(int)

```java
public boolean othersInsertsAreVisible(int type)
```

> @see java.sql.DatabaseMetaData#othersUpdatesAreVisible(int)

```java
public boolean othersUpdatesAreVisible(int type)
```

> @see java.sql.DatabaseMetaData#ownDeletesAreVisible(int)

```java
public boolean ownDeletesAreVisible(int type)
```

> @see java.sql.DatabaseMetaData#ownInsertsAreVisible(int)

```java
public boolean ownInsertsAreVisible(int type)
```

> @see java.sql.DatabaseMetaData#ownUpdatesAreVisible(int)

```java
public boolean ownUpdatesAreVisible(int type)
```

> @see java.sql.DatabaseMetaData#storesLowerCaseIdentifiers()

```java
public boolean storesLowerCaseIdentifiers()
```

> @see java.sql.DatabaseMetaData#storesLowerCaseQuotedIdentifiers()

```java
public boolean storesLowerCaseQuotedIdentifiers()
```

> @see java.sql.DatabaseMetaData#storesMixedCaseIdentifiers()

```java
public boolean storesMixedCaseIdentifiers()
```

> @see java.sql.DatabaseMetaData#storesMixedCaseQuotedIdentifiers()

```java
public boolean storesMixedCaseQuotedIdentifiers()
```

> @see java.sql.DatabaseMetaData#storesUpperCaseIdentifiers()

```java
public boolean storesUpperCaseIdentifiers()
```

> @see java.sql.DatabaseMetaData#storesUpperCaseQuotedIdentifiers()

```java
public boolean storesUpperCaseQuotedIdentifiers()
```

> @see java.sql.DatabaseMetaData#supportsAlterTableWithAddColumn()

```java
public boolean supportsAlterTableWithAddColumn()
```

> @see java.sql.DatabaseMetaData#supportsAlterTableWithDropColumn()

```java
public boolean supportsAlterTableWithDropColumn()
```

> @see java.sql.DatabaseMetaData#supportsANSI92EntryLevelSQL()

```java
public boolean supportsANSI92EntryLevelSQL()
```

> @see java.sql.DatabaseMetaData#supportsANSI92FullSQL()

```java
public boolean supportsANSI92FullSQL()
```

> @see java.sql.DatabaseMetaData#supportsANSI92IntermediateSQL()

```java
public boolean supportsANSI92IntermediateSQL()
```

> @see java.sql.DatabaseMetaData#supportsBatchUpdates()

```java
public boolean supportsBatchUpdates()
```

> @see java.sql.DatabaseMetaData#supportsCatalogsInDataManipulation()

```java
public boolean supportsCatalogsInDataManipulation()
```

> @see java.sql.DatabaseMetaData#supportsCatalogsInIndexDefinitions()

```java
public boolean supportsCatalogsInIndexDefinitions()
```

> @see java.sql.DatabaseMetaData#supportsCatalogsInPrivilegeDefinitions()

```java
public boolean supportsCatalogsInPrivilegeDefinitions()
```

> @see java.sql.DatabaseMetaData#supportsCatalogsInProcedureCalls()

```java
public boolean supportsCatalogsInProcedureCalls()
```

> @see java.sql.DatabaseMetaData#supportsCatalogsInTableDefinitions()

```java
public boolean supportsCatalogsInTableDefinitions()
```

> @see java.sql.DatabaseMetaData#supportsColumnAliasing()

```java
public boolean supportsColumnAliasing()
```

> @see java.sql.DatabaseMetaData#supportsConvert()

```java
public boolean supportsConvert()
```

> @see java.sql.DatabaseMetaData#supportsConvert(int, int)

```java
public boolean supportsConvert(int fromType, int toType)
```

> @see java.sql.DatabaseMetaData#supportsCorrelatedSubqueries()

```java
public boolean supportsCorrelatedSubqueries()
```

> @see java.sql.DatabaseMetaData#supportsDataDefinitionAndDataManipulationTransactions()

```java
public boolean supportsDataDefinitionAndDataManipulationTransactions()
```

> @see java.sql.DatabaseMetaData#supportsDataManipulationTransactionsOnly()

```java
public boolean supportsDataManipulationTransactionsOnly()
```

> @see java.sql.DatabaseMetaData#supportsDifferentTableCorrelationNames()

```java
public boolean supportsDifferentTableCorrelationNames()
```

> @see java.sql.DatabaseMetaData#supportsExpressionsInOrderBy()

```java
public boolean supportsExpressionsInOrderBy()
```

> @see java.sql.DatabaseMetaData#supportsMinimumSQLGrammar()

```java
public boolean supportsMinimumSQLGrammar()
```

> @see java.sql.DatabaseMetaData#supportsCoreSQLGrammar()

```java
public boolean supportsCoreSQLGrammar()
```

> @see java.sql.DatabaseMetaData#supportsExtendedSQLGrammar()

```java
public boolean supportsExtendedSQLGrammar()
```

> @see java.sql.DatabaseMetaData#supportsLimitedOuterJoins()

```java
public boolean supportsLimitedOuterJoins()
```

> @see java.sql.DatabaseMetaData#supportsFullOuterJoins()

```java
public boolean supportsFullOuterJoins() throws SQLException
```

> @see java.sql.DatabaseMetaData#supportsGetGeneratedKeys()

```java
public boolean supportsGetGeneratedKeys()
```

> @see java.sql.DatabaseMetaData#supportsGroupBy()

```java
public boolean supportsGroupBy()
```

> @see java.sql.DatabaseMetaData#supportsGroupByBeyondSelect()

```java
public boolean supportsGroupByBeyondSelect()
```

> @see java.sql.DatabaseMetaData#supportsGroupByUnrelated()

```java
public boolean supportsGroupByUnrelated()
```

> @see java.sql.DatabaseMetaData#supportsIntegrityEnhancementFacility()

```java
public boolean supportsIntegrityEnhancementFacility()
```

> @see java.sql.DatabaseMetaData#supportsLikeEscapeClause()

```java
public boolean supportsLikeEscapeClause()
```

> @see java.sql.DatabaseMetaData#supportsMixedCaseIdentifiers()

```java
public boolean supportsMixedCaseIdentifiers()
```

> @see java.sql.DatabaseMetaData#supportsMixedCaseQuotedIdentifiers()

```java
public boolean supportsMixedCaseQuotedIdentifiers()
```

> @see java.sql.DatabaseMetaData#supportsMultipleOpenResults()

```java
public boolean supportsMultipleOpenResults()
```

> @see java.sql.DatabaseMetaData#supportsMultipleResultSets()

```java
public boolean supportsMultipleResultSets()
```

> @see java.sql.DatabaseMetaData#supportsMultipleTransactions()

```java
public boolean supportsMultipleTransactions()
```

> @see java.sql.DatabaseMetaData#supportsNamedParameters()

```java
public boolean supportsNamedParameters()
```

> @see java.sql.DatabaseMetaData#supportsNonNullableColumns()

```java
public boolean supportsNonNullableColumns()
```

> @see java.sql.DatabaseMetaData#supportsOpenCursorsAcrossCommit()

```java
public boolean supportsOpenCursorsAcrossCommit()
```

> @see java.sql.DatabaseMetaData#supportsOpenCursorsAcrossRollback()

```java
public boolean supportsOpenCursorsAcrossRollback()
```

> @see java.sql.DatabaseMetaData#supportsOpenStatementsAcrossCommit()

```java
public boolean supportsOpenStatementsAcrossCommit()
```

> @see java.sql.DatabaseMetaData#supportsOpenStatementsAcrossRollback()

```java
public boolean supportsOpenStatementsAcrossRollback()
```

> @see java.sql.DatabaseMetaData#supportsOrderByUnrelated()

```java
public boolean supportsOrderByUnrelated()
```

> @see java.sql.DatabaseMetaData#supportsOuterJoins()

```java
public boolean supportsOuterJoins()
```

> @see java.sql.DatabaseMetaData#supportsPositionedDelete()

```java
public boolean supportsPositionedDelete()
```

> @see java.sql.DatabaseMetaData#supportsPositionedUpdate()

```java
public boolean supportsPositionedUpdate()
```

> @see java.sql.DatabaseMetaData#supportsResultSetConcurrency(int, int)

```java
public boolean supportsResultSetConcurrency(int t, int c)
```

> @see java.sql.DatabaseMetaData#supportsResultSetHoldability(int)

```java
public boolean supportsResultSetHoldability(int h)
```

> @see java.sql.DatabaseMetaData#supportsResultSetType(int)

```java
public boolean supportsResultSetType(int t)
```

> @see java.sql.DatabaseMetaData#supportsSavepoints()

```java
public boolean supportsSavepoints()
```

> @see java.sql.DatabaseMetaData#supportsSchemasInDataManipulation()

```java
public boolean supportsSchemasInDataManipulation()
```

> @see java.sql.DatabaseMetaData#supportsSchemasInIndexDefinitions()

```java
public boolean supportsSchemasInIndexDefinitions()
```

> @see java.sql.DatabaseMetaData#supportsSchemasInPrivilegeDefinitions()

```java
public boolean supportsSchemasInPrivilegeDefinitions()
```

> @see java.sql.DatabaseMetaData#supportsSchemasInProcedureCalls()

```java
public boolean supportsSchemasInProcedureCalls()
```

> @see java.sql.DatabaseMetaData#supportsSchemasInTableDefinitions()

```java
public boolean supportsSchemasInTableDefinitions()
```

> @see java.sql.DatabaseMetaData#supportsSelectForUpdate()

```java
public boolean supportsSelectForUpdate()
```

> @see java.sql.DatabaseMetaData#supportsStatementPooling()

```java
public boolean supportsStatementPooling()
```

> @see java.sql.DatabaseMetaData#supportsStoredProcedures()

```java
public boolean supportsStoredProcedures()
```

> @see java.sql.DatabaseMetaData#supportsSubqueriesInComparisons()

```java
public boolean supportsSubqueriesInComparisons()
```

> @see java.sql.DatabaseMetaData#supportsSubqueriesInExists()

```java
public boolean supportsSubqueriesInExists()
```

> @see java.sql.DatabaseMetaData#supportsSubqueriesInIns()

```java
public boolean supportsSubqueriesInIns()
```

> @see java.sql.DatabaseMetaData#supportsSubqueriesInQuantifieds()

```java
public boolean supportsSubqueriesInQuantifieds()
```

> @see java.sql.DatabaseMetaData#supportsTableCorrelationNames()

```java
public boolean supportsTableCorrelationNames()
```

> @see java.sql.DatabaseMetaData#supportsTransactionIsolationLevel(int)

```java
public boolean supportsTransactionIsolationLevel(int level)
```

> @see java.sql.DatabaseMetaData#supportsTransactions()

```java
public boolean supportsTransactions()
```

> @see java.sql.DatabaseMetaData#supportsUnion()

```java
public boolean supportsUnion()
```

> @see java.sql.DatabaseMetaData#supportsUnionAll()

```java
public boolean supportsUnionAll()
```

> @see java.sql.DatabaseMetaData#updatesAreDetected(int)

```java
public boolean updatesAreDetected(int type)
```

> @see java.sql.DatabaseMetaData#usesLocalFilePerTable()

```java
public boolean usesLocalFilePerTable()
```

> @see java.sql.DatabaseMetaData#usesLocalFiles()

```java
public boolean usesLocalFiles()
```

> @see java.sql.DatabaseMetaData#isReadOnly()

```java
public boolean isReadOnly() throws SQLException
```

> @see java.sql.DatabaseMetaData#getAttributes(java.lang.String, java.lang.String,
> java.lang.String, java.lang.String)

```java
public ResultSet getAttributes(String c, String s, String t, String a) throws SQLException
```

> @see java.sql.DatabaseMetaData#getBestRowIdentifier(java.lang.String, java.lang.String,
> java.lang.String, int, boolean)

```java
public ResultSet getBestRowIdentifier(String c, String s, String t, int scope, boolean n)
```

> @see java.sql.DatabaseMetaData#getColumnPrivileges(java.lang.String, java.lang.String,
> java.lang.String, java.lang.String)

```java
public ResultSet getColumnPrivileges(String c, String s, String t, String colPat)
```

> @see java.sql.DatabaseMetaData#getColumns(java.lang.String, java.lang.String,
> java.lang.String, java.lang.String)

```java
public ResultSet getColumns(String c, String s, String tblNamePattern, String colNamePattern)
```

> @see java.sql.DatabaseMetaData#getCrossReference(java.lang.String, java.lang.String,
> java.lang.String, java.lang.String, java.lang.String, java.lang.String)

```java
public ResultSet getCrossReference(
            String pc, String ps, String pt, String fc, String fs, String ft) throws SQLException
```

> @see java.sql.DatabaseMetaData#getSchemas()

```java
public ResultSet getSchemas() throws SQLException
```

> @see java.sql.DatabaseMetaData#getCatalogs()

```java
public ResultSet getCatalogs() throws SQLException
```

> @see java.sql.DatabaseMetaData#getPrimaryKeys(java.lang.String, java.lang.String,
> java.lang.String)

```java
public ResultSet getPrimaryKeys(String c, String s, String table) throws SQLException
```

> @see java.sql.DatabaseMetaData#getExportedKeys(java.lang.String, java.lang.String,
> java.lang.String)

```java
public ResultSet getExportedKeys(String catalog, String schema, String table)
```

```java
final ImportedKeyFinder impFkFinder = ...
```

> @see java.sql.DatabaseMetaData#getImportedKeys(java.lang.String, java.lang.String,
> java.lang.String)

```java
public ResultSet getImportedKeys(String catalog, String schema, String table)
```

```java
final ImportedKeyFinder impFkFinder = ...
```

> @see java.sql.DatabaseMetaData#getIndexInfo(java.lang.String, java.lang.String,
> java.lang.String, boolean, boolean)

```java
public ResultSet getIndexInfo(String c, String s, String table, boolean u, boolean approximate)
```

> @see java.sql.DatabaseMetaData#getProcedureColumns(java.lang.String, java.lang.String,
> java.lang.String, java.lang.String)

```java
public ResultSet getProcedureColumns(String c, String s, String p, String colPat)
```

> @see java.sql.DatabaseMetaData#getProcedures(java.lang.String, java.lang.String,
> java.lang.String)

```java
public ResultSet getProcedures(String c, String s, String p) throws SQLException
```

> @see java.sql.DatabaseMetaData#getSuperTables(java.lang.String, java.lang.String,
> java.lang.String)

```java
public ResultSet getSuperTables(String c, String s, String t) throws SQLException
```

> @see java.sql.DatabaseMetaData#getSuperTypes(java.lang.String, java.lang.String,
> java.lang.String)

```java
public ResultSet getSuperTypes(String c, String s, String t) throws SQLException
```

> @see java.sql.DatabaseMetaData#getTablePrivileges(java.lang.String, java.lang.String,
> java.lang.String)

```java
public ResultSet getTablePrivileges(String c, String s, String t) throws SQLException
```

> @see java.sql.DatabaseMetaData#getTables(java.lang.String, java.lang.String,
> java.lang.String, java.lang.String[])

```java
public synchronized ResultSet getTables(
            String c, String s, String tblNamePattern, String[] types) throws SQLException
```

> @see java.sql.DatabaseMetaData#getTableTypes()

```java
public ResultSet getTableTypes() throws SQLException
```

> @see java.sql.DatabaseMetaData#getTypeInfo()

```java
public ResultSet getTypeInfo() throws SQLException
```

> @see java.sql.DatabaseMetaData#getUDTs(java.lang.String, java.lang.String, java.lang.String,
> int[])

```java
public ResultSet getUDTs(String c, String s, String t, int[] types) throws SQLException
```

> @see java.sql.DatabaseMetaData#getVersionColumns(java.lang.String, java.lang.String,
> java.lang.String)

```java
public ResultSet getVersionColumns(String c, String s, String t) throws SQLException
```

> @deprecated Not exactly sure what this function does, as it is not implementing any
> interface, and is not used anywhere in the code. Deprecated since 3.43.0.0.

```java
    @Deprecated
public ResultSet getGeneratedKeys() throws SQLException
```

> Not implemented yet.

```java
public Struct createStruct(String t, Object[] attr) throws SQLException
```

> Not implemented yet.

```java
public ResultSet getFunctionColumns(String a, String b, String c, String d)
```

> @return The primary key name if any.

```java
public String getName()
```

> @return Array of primary key column(s) if any.

```java
public String[] getColumns()
```

```java
public String getFkTableName()
```

```java
public List<ForeignKey> getFkList()
```

```java
public String getFkName()
```

```java
public String[] getColumnMapping(int colSeq)
```

```java
public int getColumnMappingCount()
```

```java
public String getPkTableName()
```

```java
public String getFkTableName()
```

```java
public String getOnUpdate()
```

```java
public String getOnDelete()
```

```java
public String getMatch()
```

```java
            @Override
public String toString()
```

#### `org/sqlite/jdbc3/JDBC3PreparedStatement.java`

```java
public abstract class JDBC3PreparedStatement extends CorePreparedStatement
```

> @see java.sql.PreparedStatement#clearParameters()

```java
public void clearParameters() throws SQLException
```

> @see java.sql.PreparedStatement#execute()

```java
public boolean execute() throws SQLException
```

> @see java.sql.PreparedStatement#executeQuery()

```java
public ResultSet executeQuery() throws SQLException
```

> @see java.sql.PreparedStatement#executeUpdate()

```java
public int executeUpdate() throws SQLException
```

> @see java.sql.PreparedStatement#executeLargeUpdate()

```java
public long executeLargeUpdate() throws SQLException
```

> @see java.sql.PreparedStatement#addBatch()

```java
public void addBatch() throws SQLException
```

> @see java.sql.PreparedStatement#getParameterMetaData()

```java
public ParameterMetaData getParameterMetaData()
```

> @see java.sql.ParameterMetaData#getParameterCount()

```java
public int getParameterCount() throws SQLException
```

> @see java.sql.ParameterMetaData#getParameterClassName(int)

```java
public String getParameterClassName(int param) throws SQLException
```

> @see java.sql.ParameterMetaData#getParameterTypeName(int)

```java
public String getParameterTypeName(int pos) throws SQLException
```

> @see java.sql.ParameterMetaData#getParameterType(int)

```java
public int getParameterType(int pos) throws SQLException
```

> @see java.sql.ParameterMetaData#getParameterMode(int)

```java
public int getParameterMode(int pos)
```

> @see java.sql.ParameterMetaData#getPrecision(int)

```java
public int getPrecision(int pos)
```

> @see java.sql.ParameterMetaData#getScale(int)

```java
public int getScale(int pos)
```

> @see java.sql.ParameterMetaData#isNullable(int)

```java
public int isNullable(int pos)
```

> @see java.sql.ParameterMetaData#isSigned(int)

```java
public boolean isSigned(int pos)
```

> @return

```java
public Statement getStatement()
```

> @see java.sql.PreparedStatement#setBigDecimal(int, java.math.BigDecimal)

```java
public void setBigDecimal(int pos, BigDecimal value) throws SQLException
```

> @see java.sql.PreparedStatement#setBinaryStream(int, java.io.InputStream, int)

```java
public void setBinaryStream(int pos, InputStream istream, int length) throws SQLException
```

> @see java.sql.PreparedStatement#setAsciiStream(int, java.io.InputStream, int)

```java
public void setAsciiStream(int pos, InputStream istream, int length) throws SQLException
```

> @see java.sql.PreparedStatement#setUnicodeStream(int, java.io.InputStream, int)

```java
public void setUnicodeStream(int pos, InputStream istream, int length) throws SQLException
```

> @see java.sql.PreparedStatement#setBoolean(int, boolean)

```java
public void setBoolean(int pos, boolean value) throws SQLException
```

> @see java.sql.PreparedStatement#setByte(int, byte)

```java
public void setByte(int pos, byte value) throws SQLException
```

> @see java.sql.PreparedStatement#setBytes(int, byte[])

```java
public void setBytes(int pos, byte[] value) throws SQLException
```

> @see java.sql.PreparedStatement#setDouble(int, double)

```java
public void setDouble(int pos, double value) throws SQLException
```

> @see java.sql.PreparedStatement#setFloat(int, float)

```java
public void setFloat(int pos, float value) throws SQLException
```

> @see java.sql.PreparedStatement#setInt(int, int)

```java
public void setInt(int pos, int value) throws SQLException
```

> @see java.sql.PreparedStatement#setLong(int, long)

```java
public void setLong(int pos, long value) throws SQLException
```

> @see java.sql.PreparedStatement#setNull(int, int)

```java
public void setNull(int pos, int u1) throws SQLException
```

> @see java.sql.PreparedStatement#setNull(int, int, java.lang.String)

```java
public void setNull(int pos, int u1, String u2) throws SQLException
```

> @see java.sql.PreparedStatement#setObject(int, java.lang.Object)

```java
public void setObject(int pos, Object value) throws SQLException
```

> @see java.sql.PreparedStatement#setObject(int, java.lang.Object, int)

```java
public void setObject(int p, Object v, int t) throws SQLException
```

> @see java.sql.PreparedStatement#setObject(int, java.lang.Object, int, int)

```java
public void setObject(int p, Object v, int t, int s) throws SQLException
```

> @see java.sql.PreparedStatement#setShort(int, short)

```java
public void setShort(int pos, short value) throws SQLException
```

> @see java.sql.PreparedStatement#setString(int, java.lang.String)

```java
public void setString(int pos, String value) throws SQLException
```

> @see java.sql.PreparedStatement#setCharacterStream(int, java.io.Reader, int)

```java
public void setCharacterStream(int pos, Reader reader, int length) throws SQLException
```

> @see java.sql.PreparedStatement#setDate(int, java.sql.Date)

```java
public void setDate(int pos, Date x) throws SQLException
```

> @see java.sql.PreparedStatement#setDate(int, java.sql.Date, java.util.Calendar)

```java
public void setDate(int pos, Date x, Calendar cal) throws SQLException
```

> @see java.sql.PreparedStatement#setTime(int, java.sql.Time)

```java
public void setTime(int pos, Time x) throws SQLException
```

> @see java.sql.PreparedStatement#setTime(int, java.sql.Time, java.util.Calendar)

```java
public void setTime(int pos, Time x, Calendar cal) throws SQLException
```

> @see java.sql.PreparedStatement#setTimestamp(int, java.sql.Timestamp)

```java
public void setTimestamp(int pos, Timestamp x) throws SQLException
```

> @see java.sql.PreparedStatement#setTimestamp(int, java.sql.Timestamp, java.util.Calendar)

```java
public void setTimestamp(int pos, Timestamp x, Calendar cal) throws SQLException
```

> @see java.sql.PreparedStatement#getMetaData()

```java
public ResultSetMetaData getMetaData() throws SQLException
```

```java
public void setArray(int i, Array x) throws SQLException
```

```java
public void setBlob(int i, Blob x) throws SQLException
```

```java
public void setClob(int i, Clob x) throws SQLException
```

```java
public void setRef(int i, Ref x) throws SQLException
```

```java
public void setURL(int pos, URL x) throws SQLException
```

> @see org.sqlite.core.CoreStatement#exec(java.lang.String)

```java
    @Override
public boolean execute(String sql) throws SQLException
```

```java
public boolean execute(String sql, int autoGeneratedKeys) throws SQLException
```

```java
public boolean execute(String sql, int[] colinds) throws SQLException
```

```java
public boolean execute(String sql, String[] colnames) throws SQLException
```

> @see org.sqlite.core.CoreStatement#exec(java.lang.String)

```java
    @Override
public int executeUpdate(String sql) throws SQLException
```

```java
public int executeUpdate(String sql, int autoGeneratedKeys) throws SQLException
```

```java
public int executeUpdate(String sql, int[] colinds) throws SQLException
```

```java
public int executeUpdate(String sql, String[] cols) throws SQLException
```

```java
public long executeLargeUpdate(String sql) throws SQLException
```

```java
public long executeLargeUpdate(String sql, int autoGeneratedKeys) throws SQLException
```

```java
public long executeLargeUpdate(String sql, int[] colinds) throws SQLException
```

```java
public long executeLargeUpdate(String sql, String[] cols) throws SQLException
```

> @see org.sqlite.core.CoreStatement#exec(String)

```java
    @Override
public ResultSet executeQuery(String sql) throws SQLException
```

```java
    @Override
public void addBatch(String sql) throws SQLException
```

#### `org/sqlite/jdbc3/JDBC3ResultSet.java`

```java
public abstract class JDBC3ResultSet extends CoreResultSet
```

> returns col in [1,x] form
>
> @see java.sql.ResultSet#findColumn(java.lang.String)

```java
public int findColumn(String col) throws SQLException
```

> @see java.sql.ResultSet#next()

```java
public boolean next() throws SQLException
```

> @see java.sql.ResultSet#getType()

```java
public int getType()
```

> @see java.sql.ResultSet#getFetchSize()

```java
public int getFetchSize()
```

> @see java.sql.ResultSet#setFetchSize(int)

```java
public void setFetchSize(int rows) throws SQLException
```

> @see java.sql.ResultSet#getFetchDirection()

```java
public int getFetchDirection() throws SQLException
```

> @see java.sql.ResultSet#setFetchDirection(int)

```java
public void setFetchDirection(int d) throws SQLException
```

> @see java.sql.ResultSet#isAfterLast()

```java
public boolean isAfterLast()
```

> @see java.sql.ResultSet#isBeforeFirst()

```java
public boolean isBeforeFirst()
```

> @see java.sql.ResultSet#isFirst()

```java
public boolean isFirst()
```

> @see java.sql.ResultSet#isLast()

```java
public boolean isLast() throws SQLException
```

> @see java.sql.ResultSet#getRow()

```java
public int getRow()
```

> @see java.sql.ResultSet#wasNull()

```java
public boolean wasNull() throws SQLException
```

> @see java.sql.ResultSet#getBigDecimal(int)

```java
public BigDecimal getBigDecimal(int col) throws SQLException
```

```java
final String stringValue = ...
```

> @see java.sql.ResultSet#getBigDecimal(java.lang.String)

```java
public BigDecimal getBigDecimal(String col) throws SQLException
```

> @see java.sql.ResultSet#getBoolean(int)

```java
public boolean getBoolean(int col) throws SQLException
```

> @see java.sql.ResultSet#getBoolean(java.lang.String)

```java
public boolean getBoolean(String col) throws SQLException
```

> @see java.sql.ResultSet#getBinaryStream(int)

```java
public InputStream getBinaryStream(int col) throws SQLException
```

> @see java.sql.ResultSet#getBinaryStream(java.lang.String)

```java
public InputStream getBinaryStream(String col) throws SQLException
```

> @see java.sql.ResultSet#getByte(int)

```java
public byte getByte(int col) throws SQLException
```

> @see java.sql.ResultSet#getByte(java.lang.String)

```java
public byte getByte(String col) throws SQLException
```

> @see java.sql.ResultSet#getBytes(int)

```java
public byte[] getBytes(int col) throws SQLException
```

> @see java.sql.ResultSet#getBytes(java.lang.String)

```java
public byte[] getBytes(String col) throws SQLException
```

> @see java.sql.ResultSet#getCharacterStream(int)

```java
public Reader getCharacterStream(int col) throws SQLException
```

> @see java.sql.ResultSet#getCharacterStream(java.lang.String)

```java
public Reader getCharacterStream(String col) throws SQLException
```

> @see java.sql.ResultSet#getDate(int)

```java
public Date getDate(int col) throws SQLException
```

> @see java.sql.ResultSet#getDate(int, java.util.Calendar)

```java
public Date getDate(int col, Calendar cal) throws SQLException
```

> @see java.sql.ResultSet#getDate(java.lang.String)

```java
public Date getDate(String col) throws SQLException
```

> @see java.sql.ResultSet#getDate(java.lang.String, java.util.Calendar)

```java
public Date getDate(String col, Calendar cal) throws SQLException
```

> @see java.sql.ResultSet#getDouble(int)

```java
public double getDouble(int col) throws SQLException
```

> @see java.sql.ResultSet#getDouble(java.lang.String)

```java
public double getDouble(String col) throws SQLException
```

> @see java.sql.ResultSet#getFloat(int)

```java
public float getFloat(int col) throws SQLException
```

> @see java.sql.ResultSet#getFloat(java.lang.String)

```java
public float getFloat(String col) throws SQLException
```

> @see java.sql.ResultSet#getInt(int)

```java
public int getInt(int col) throws SQLException
```

> @see java.sql.ResultSet#getInt(java.lang.String)

```java
public int getInt(String col) throws SQLException
```

> @see java.sql.ResultSet#getLong(int)

```java
public long getLong(int col) throws SQLException
```

> @see java.sql.ResultSet#getLong(java.lang.String)

```java
public long getLong(String col) throws SQLException
```

> @see java.sql.ResultSet#getShort(int)

```java
public short getShort(int col) throws SQLException
```

> @see java.sql.ResultSet#getShort(java.lang.String)

```java
public short getShort(String col) throws SQLException
```

> @see java.sql.ResultSet#getString(int)

```java
public String getString(int col) throws SQLException
```

> @see java.sql.ResultSet#getString(java.lang.String)

```java
public String getString(String col) throws SQLException
```

> @see java.sql.ResultSet#getTime(int)

```java
public Time getTime(int col) throws SQLException
```

> @see java.sql.ResultSet#getTime(int, java.util.Calendar)

```java
public Time getTime(int col, Calendar cal) throws SQLException
```

> @see java.sql.ResultSet#getTime(java.lang.String)

```java
public Time getTime(String col) throws SQLException
```

> @see java.sql.ResultSet#getTime(java.lang.String, java.util.Calendar)

```java
public Time getTime(String col, Calendar cal) throws SQLException
```

> @see java.sql.ResultSet#getTimestamp(int)

```java
public Timestamp getTimestamp(int col) throws SQLException
```

> @see java.sql.ResultSet#getTimestamp(int, java.util.Calendar)

```java
public Timestamp getTimestamp(int col, Calendar cal) throws SQLException
```

> @see java.sql.ResultSet#getTimestamp(java.lang.String)

```java
public Timestamp getTimestamp(String col) throws SQLException
```

> @see java.sql.ResultSet#getTimestamp(java.lang.String, java.util.Calendar)

```java
public Timestamp getTimestamp(String c, Calendar ca) throws SQLException
```

> @see java.sql.ResultSet#getObject(int)

```java
public Object getObject(int col) throws SQLException
```

> @see java.sql.ResultSet#getObject(java.lang.String)

```java
public Object getObject(String col) throws SQLException
```

> @see java.sql.ResultSet#getStatement()

```java
public Statement getStatement()
```

> @see java.sql.ResultSet#getCursorName()

```java
public String getCursorName()
```

> @see java.sql.ResultSet#getWarnings()

```java
public SQLWarning getWarnings()
```

> @see java.sql.ResultSet#clearWarnings()

```java
public void clearWarnings()
```

> @see java.sql.ResultSet#getMetaData()

```java
public ResultSetMetaData getMetaData()
```

> @see java.sql.ResultSetMetaData#getCatalogName(int)

```java
public String getCatalogName(int col) throws SQLException
```

> @see java.sql.ResultSetMetaData#getColumnClassName(int)

```java
public String getColumnClassName(int col) throws SQLException
```

> @see java.sql.ResultSetMetaData#getColumnCount()

```java
public int getColumnCount() throws SQLException
```

> @see java.sql.ResultSetMetaData#getColumnDisplaySize(int)

```java
public int getColumnDisplaySize(int col)
```

> @see java.sql.ResultSetMetaData#getColumnLabel(int)

```java
public String getColumnLabel(int col) throws SQLException
```

> @see java.sql.ResultSetMetaData#getColumnName(int)

```java
public String getColumnName(int col) throws SQLException
```

> @see java.sql.ResultSetMetaData#getColumnType(int)

```java
public int getColumnType(int col) throws SQLException
```

> @return The data type from either the 'create table' statement, or CAST(expr AS TYPE)
> otherwise sqlite3_value_type.
> @see java.sql.ResultSetMetaData#getColumnTypeName(int)

```java
public String getColumnTypeName(int col) throws SQLException
```

> @see java.sql.ResultSetMetaData#getPrecision(int)

```java
public int getPrecision(int col) throws SQLException
```

> @see java.sql.ResultSetMetaData#getScale(int)

```java
public int getScale(int col) throws SQLException
```

> @see java.sql.ResultSetMetaData#getSchemaName(int)

```java
public String getSchemaName(int col)
```

> @see java.sql.ResultSetMetaData#getTableName(int)

```java
public String getTableName(int col) throws SQLException
```

```java
final String tableName = ...
```

> @see java.sql.ResultSetMetaData#isNullable(int)

```java
public int isNullable(int col) throws SQLException
```

> @see java.sql.ResultSetMetaData#isAutoIncrement(int)

```java
public boolean isAutoIncrement(int col) throws SQLException
```

> @see java.sql.ResultSetMetaData#isCaseSensitive(int)

```java
public boolean isCaseSensitive(int col)
```

> @see java.sql.ResultSetMetaData#isCurrency(int)

```java
public boolean isCurrency(int col)
```

> @see java.sql.ResultSetMetaData#isDefinitelyWritable(int)

```java
public boolean isDefinitelyWritable(int col)
```

> @see java.sql.ResultSetMetaData#isReadOnly(int)

```java
public boolean isReadOnly(int col)
```

> @see java.sql.ResultSetMetaData#isSearchable(int)

```java
public boolean isSearchable(int col)
```

> @see java.sql.ResultSetMetaData#isSigned(int)

```java
public boolean isSigned(int col) throws SQLException
```

> @see java.sql.ResultSetMetaData#isWritable(int)

```java
public boolean isWritable(int col)
```

> @see java.sql.ResultSet#getConcurrency()

```java
public int getConcurrency()
```

> @see java.sql.ResultSet#rowDeleted()

```java
public boolean rowDeleted()
```

> @see java.sql.ResultSet#rowInserted()

```java
public boolean rowInserted()
```

> @see java.sql.ResultSet#rowUpdated()

```java
public boolean rowUpdated()
```

#### `org/sqlite/jdbc3/JDBC3Savepoint.java`

```java
public class JDBC3Savepoint implements Savepoint
```

```java
final int id ;
```

```java
final String name ;
```

```java
public int getSavepointId() throws SQLException
```

```java
public String getSavepointName() throws SQLException
```

#### `org/sqlite/jdbc3/JDBC3Statement.java`

```java
public abstract class JDBC3Statement extends CoreStatement
```

> @see java.sql.Statement#close()

```java
public void close() throws SQLException
```

> @see java.sql.Statement#execute(java.lang.String)

```java
public boolean execute(final String sql) throws SQLException
```

> @see java.sql.Statement#execute(java.lang.String, int)

```java
public boolean execute(String sql, int autoGeneratedKeys) throws SQLException
```

> @param closeStmt Whether to close this statement when the resultset is closed.
> @see java.sql.Statement#executeQuery(java.lang.String)

```java
public ResultSet executeQuery(String sql, boolean closeStmt) throws SQLException
```

> @see java.sql.Statement#executeQuery(java.lang.String)

```java
public ResultSet executeQuery(String sql) throws SQLException
```

```java
static class BackupObserver implements ProgressObserver
```

```java
public void progress(int remaining, int pageCount)
```

> @see java.sql.Statement#executeUpdate(java.lang.String)

```java
public int executeUpdate(final String sql) throws SQLException
```

> @see java.sql.Statement#executeUpdate(java.lang.String, int)

```java
public int executeUpdate(String sql, int autoGeneratedKeys) throws SQLException
```

> @see java.sql.Statement#executeLargeUpdate(java.lang.String)

```java
public long executeLargeUpdate(String sql) throws SQLException
```

> @see java.sql.Statement#executeLargeUpdate(java.lang.String, int)

```java
public long executeLargeUpdate(String sql, int autoGeneratedKeys) throws SQLException
```

> @see java.sql.Statement#getResultSet()

```java
public ResultSet getResultSet() throws SQLException
```

> This function has a complex behaviour best understood by carefully reading the JavaDoc for
> getMoreResults() and considering the test StatementTest.execute().
>
> @see java.sql.Statement#getUpdateCount()

```java
public int getUpdateCount() throws SQLException
```

> This function has a complex behaviour best understood by carefully reading the JavaDoc for
> getMoreResults() and considering the test StatementTest.execute().
>
> @see java.sql.Statement#getLargeUpdateCount()

```java
public long getLargeUpdateCount() throws SQLException
```

> @see java.sql.Statement#addBatch(java.lang.String)

```java
public void addBatch(String sql) throws SQLException
```

> @see java.sql.Statement#clearBatch()

```java
public void clearBatch() throws SQLException
```

> @see java.sql.Statement#executeBatch()

```java
public int[] executeBatch() throws SQLException
```

> @see java.sql.Statement#executeLargeBatch()

```java
public long[] executeLargeBatch() throws SQLException
```

> @see java.sql.Statement#setCursorName(java.lang.String)

```java
public void setCursorName(String name)
```

> @see java.sql.Statement#getWarnings()

```java
public SQLWarning getWarnings() throws SQLException
```

> @see java.sql.Statement#clearWarnings()

```java
public void clearWarnings() throws SQLException
```

> @see java.sql.Statement#getConnection()

```java
public Connection getConnection() throws SQLException
```

> @see java.sql.Statement#cancel()

```java
public void cancel() throws SQLException
```

> @see java.sql.Statement#getQueryTimeout()

```java
public int getQueryTimeout() throws SQLException
```

> @see java.sql.Statement#setQueryTimeout(int)

```java
public void setQueryTimeout(int seconds) throws SQLException
```

> @see java.sql.Statement#getMaxRows()

```java
public int getMaxRows() throws SQLException
```

> @see java.sql.Statement#getLargeMaxRows()

```java
public long getLargeMaxRows() throws SQLException
```

> @see java.sql.Statement#setMaxRows(int)

```java
public void setMaxRows(int max) throws SQLException
```

> @see java.sql.Statement#setLargeMaxRows(long)

```java
public void setLargeMaxRows(long max) throws SQLException
```

> @see java.sql.Statement#getMaxFieldSize()

```java
public int getMaxFieldSize() throws SQLException
```

> @see java.sql.Statement#setMaxFieldSize(int)

```java
public void setMaxFieldSize(int max) throws SQLException
```

> @see java.sql.Statement#getFetchSize()

```java
public int getFetchSize() throws SQLException
```

> @see java.sql.Statement#setFetchSize(int)

```java
public void setFetchSize(int r) throws SQLException
```

> @see java.sql.Statement#getFetchDirection()

```java
public int getFetchDirection() throws SQLException
```

> @see java.sql.Statement#setFetchDirection(int)

```java
public void setFetchDirection(int direction) throws SQLException
```

> SQLite does not support multiple results from execute().
>
> @see java.sql.Statement#getMoreResults()

```java
public boolean getMoreResults() throws SQLException
```

> @see java.sql.Statement#getMoreResults(int)

```java
public boolean getMoreResults(int current) throws SQLException
```

> @see java.sql.Statement#getResultSetConcurrency()

```java
public int getResultSetConcurrency() throws SQLException
```

> @see java.sql.Statement#getResultSetHoldability()

```java
public int getResultSetHoldability() throws SQLException
```

> @see java.sql.Statement#getResultSetType()

```java
public int getResultSetType() throws SQLException
```

> @see java.sql.Statement#setEscapeProcessing(boolean)

```java
public void setEscapeProcessing(boolean enable)
```

```java
public boolean execute(String sql, int[] colinds) throws SQLException
```

```java
public boolean execute(String sql, String[] colnames) throws SQLException
```

```java
public int executeUpdate(String sql, int[] colinds) throws SQLException
```

```java
public int executeUpdate(String sql, String[] cols) throws SQLException
```

```java
public long executeLargeUpdate(String sql, int[] colinds) throws SQLException
```

```java
public long executeLargeUpdate(String sql, String[] cols) throws SQLException
```

#### `org/sqlite/jdbc4/JDBC4Connection.java`

```java
public class JDBC4Connection extends JDBC3Connection
```

```java
public Statement createStatement(int rst, int rsc, int rsh) throws SQLException
```

```java
public PreparedStatement prepareStatement(String sql, int rst, int rsc, int rsh)
```

> @see java.sql.Connection#isClosed()

```java
public boolean isClosed() throws SQLException
```

```java
public <T> T unwrap(Class<T> iface) throws ClassCastException
```

```java
public boolean isWrapperFor(Class<?> iface)
```

```java
public Clob createClob() throws SQLException
```

```java
public Blob createBlob() throws SQLException
```

```java
public NClob createNClob() throws SQLException
```

```java
public SQLXML createSQLXML() throws SQLException
```

```java
public boolean isValid(int timeout) throws SQLException
```

```java
public void setClientInfo(String name, String value) throws SQLClientInfoException
```

```java
public void setClientInfo(Properties properties) throws SQLClientInfoException
```

```java
public String getClientInfo(String name) throws SQLException
```

```java
public Properties getClientInfo() throws SQLException
```

```java
public Array createArrayOf(String typeName, Object[] elements) throws SQLException
```

#### `org/sqlite/jdbc4/JDBC4DatabaseMetaData.java`

```java
public class JDBC4DatabaseMetaData extends JDBC3DatabaseMetaData
```

```java
public <T> T unwrap(Class<T> iface) throws ClassCastException
```

```java
public boolean isWrapperFor(Class<?> iface)
```

```java
public RowIdLifetime getRowIdLifetime() throws SQLException
```

```java
public ResultSet getSchemas(String catalog, String schemaPattern) throws SQLException
```

```java
public boolean supportsStoredFunctionsUsingCallSyntax() throws SQLException
```

```java
public boolean autoCommitFailureClosesAllResultSets() throws SQLException
```

```java
public ResultSet getClientInfoProperties() throws SQLException
```

```java
public ResultSet getFunctions(String catalog, String schemaPattern, String functionNamePattern)
```

```java
public ResultSet getPseudoColumns(
            String catalog, String schemaPattern, String tableNamePattern, String columnNamePattern)
```

```java
public boolean generatedKeyAlwaysReturned() throws SQLException
```

#### `org/sqlite/jdbc4/JDBC4PooledConnection.java`

```java
public abstract class JDBC4PooledConnection implements PooledConnection
```

```java
public void addStatementEventListener(StatementEventListener listener)
```

```java
public void removeStatementEventListener(StatementEventListener listener)
```

#### `org/sqlite/jdbc4/JDBC4PreparedStatement.java`

```java
public class JDBC4PreparedStatement extends JDBC3PreparedStatement
        implements PreparedStatement, ParameterMetaData
```

```java
    @Override
public String toString()
```

```java
public void setRowId(int parameterIndex, RowId x) throws SQLException
```

```java
public void setNString(int parameterIndex, String value) throws SQLException
```

```java
public void setNCharacterStream(int parameterIndex, Reader value, long length)
```

```java
public void setNClob(int parameterIndex, NClob value) throws SQLException
```

```java
public void setClob(int parameterIndex, Reader reader, long length) throws SQLException
```

```java
public void setBlob(int parameterIndex, InputStream inputStream, long length)
```

```java
public void setNClob(int parameterIndex, Reader reader, long length) throws SQLException
```

```java
public void setSQLXML(int parameterIndex, SQLXML xmlObject) throws SQLException
```

```java
public void setAsciiStream(int parameterIndex, InputStream x, long length) throws SQLException
```

```java
public void setBinaryStream(int parameterIndex, InputStream x, long length)
```

```java
public void setCharacterStream(int parameterIndex, Reader reader, long length)
```

```java
public void setAsciiStream(int parameterIndex, InputStream x) throws SQLException
```

```java
public void setBinaryStream(int parameterIndex, InputStream x) throws SQLException
```

```java
public void setCharacterStream(int parameterIndex, Reader reader) throws SQLException
```

```java
public void setNCharacterStream(int parameterIndex, Reader value) throws SQLException
```

```java
public void setClob(int parameterIndex, Reader reader) throws SQLException
```

```java
public void setBlob(int parameterIndex, InputStream inputStream) throws SQLException
```

```java
public void setNClob(int parameterIndex, Reader reader) throws SQLException
```

#### `org/sqlite/jdbc4/JDBC4ResultSet.java`

```java
public class JDBC4ResultSet extends JDBC3ResultSet implements ResultSet, ResultSetMetaData
```

```java
    @Override
public void close() throws SQLException
```

```java
final boolean wasOpen = ...
```

```java
public <T> T unwrap(Class<T> iface) throws ClassCastException
```

```java
public boolean isWrapperFor(Class<?> iface)
```

```java
public RowId getRowId(int columnIndex) throws SQLException
```

```java
public RowId getRowId(String columnLabel) throws SQLException
```

```java
public void updateRowId(int columnIndex, RowId x) throws SQLException
```

```java
public void updateRowId(String columnLabel, RowId x) throws SQLException
```

```java
public int getHoldability() throws SQLException
```

```java
public boolean isClosed() throws SQLException
```

```java
public void updateNString(int columnIndex, String nString) throws SQLException
```

```java
public void updateNString(String columnLabel, String nString) throws SQLException
```

```java
public void updateNClob(int columnIndex, NClob nClob) throws SQLException
```

```java
public void updateNClob(String columnLabel, NClob nClob) throws SQLException
```

```java
public NClob getNClob(int columnIndex) throws SQLException
```

```java
public NClob getNClob(String columnLabel) throws SQLException
```

```java
public SQLXML getSQLXML(int columnIndex) throws SQLException
```

```java
public SQLXML getSQLXML(String columnLabel) throws SQLException
```

```java
public void updateSQLXML(int columnIndex, SQLXML xmlObject) throws SQLException
```

```java
public void updateSQLXML(String columnLabel, SQLXML xmlObject) throws SQLException
```

```java
public String getNString(int columnIndex) throws SQLException
```

```java
public String getNString(String columnLabel) throws SQLException
```

```java
public Reader getNCharacterStream(int col) throws SQLException
```

```java
public Reader getNCharacterStream(String col) throws SQLException
```

```java
public void updateNCharacterStream(int columnIndex, Reader x, long length) throws SQLException
```

```java
public void updateNCharacterStream(String columnLabel, Reader reader, long length)
```

```java
public void updateAsciiStream(int columnIndex, InputStream x, long length) throws SQLException
```

```java
public void updateBinaryStream(int columnIndex, InputStream x, long length)
```

```java
public void updateCharacterStream(int columnIndex, Reader x, long length) throws SQLException
```

```java
public void updateAsciiStream(String columnLabel, InputStream x, long length)
```

```java
public void updateBinaryStream(String columnLabel, InputStream x, long length)
```

```java
public void updateCharacterStream(String columnLabel, Reader reader, long length)
```

```java
public void updateBlob(int columnIndex, InputStream inputStream, long length)
```

```java
public void updateBlob(String columnLabel, InputStream inputStream, long length)
```

```java
public void updateClob(int columnIndex, Reader reader, long length) throws SQLException
```

```java
public void updateClob(String columnLabel, Reader reader, long length) throws SQLException
```

```java
public void updateNClob(int columnIndex, Reader reader, long length) throws SQLException
```

```java
public void updateNClob(String columnLabel, Reader reader, long length) throws SQLException
```

```java
public void updateNCharacterStream(int columnIndex, Reader x) throws SQLException
```

```java
public void updateNCharacterStream(String columnLabel, Reader reader) throws SQLException
```

```java
public void updateAsciiStream(int columnIndex, InputStream x) throws SQLException
```

```java
public void updateBinaryStream(int columnIndex, InputStream x) throws SQLException
```

```java
public void updateCharacterStream(int columnIndex, Reader x) throws SQLException
```

```java
public void updateAsciiStream(String columnLabel, InputStream x) throws SQLException
```

```java
public void updateBinaryStream(String columnLabel, InputStream x) throws SQLException
```

```java
public void updateCharacterStream(String columnLabel, Reader reader) throws SQLException
```

```java
public void updateBlob(int columnIndex, InputStream inputStream) throws SQLException
```

```java
public void updateBlob(String columnLabel, InputStream inputStream) throws SQLException
```

```java
public void updateClob(int columnIndex, Reader reader) throws SQLException
```

```java
public void updateClob(String columnLabel, Reader reader) throws SQLException
```

```java
public void updateNClob(int columnIndex, Reader reader) throws SQLException
```

```java
public void updateNClob(String columnLabel, Reader reader) throws SQLException
```

```java
public <T> T getObject(int columnIndex, Class<T> type) throws SQLException
```

```java
public <T> T getObject(String columnLabel, Class<T> type) throws SQLException
```

```java
public Array getArray(int i) throws SQLException
```

```java
public Array getArray(String col) throws SQLException
```

```java
public InputStream getAsciiStream(int col) throws SQLException
```

```java
public InputStream getAsciiStream(String col) throws SQLException
```

```java
    @Deprecated
public BigDecimal getBigDecimal(int col, int s) throws SQLException
```

```java
    @Deprecated
public BigDecimal getBigDecimal(String col, int s) throws SQLException
```

```java
public Blob getBlob(int col) throws SQLException
```

```java
public Blob getBlob(String col) throws SQLException
```

```java
public Clob getClob(int col) throws SQLException
```

```java
public Clob getClob(String col) throws SQLException
```

```java
    @SuppressWarnings("rawtypes")
public Object getObject(int col, Map map) throws SQLException
```

```java
    @SuppressWarnings("rawtypes")
public Object getObject(String col, Map map) throws SQLException
```

```java
public Ref getRef(int i) throws SQLException
```

```java
public Ref getRef(String col) throws SQLException
```

```java
public InputStream getUnicodeStream(int col) throws SQLException
```

```java
public InputStream getUnicodeStream(String col) throws SQLException
```

```java
public URL getURL(int col) throws SQLException
```

```java
public URL getURL(String col) throws SQLException
```

```java
public void insertRow() throws SQLException
```

```java
public void moveToCurrentRow() throws SQLException
```

```java
public void moveToInsertRow() throws SQLException
```

```java
public boolean last() throws SQLException
```

```java
public boolean previous() throws SQLException
```

```java
public boolean relative(int rows) throws SQLException
```

```java
public boolean absolute(int row) throws SQLException
```

```java
public void afterLast() throws SQLException
```

```java
public void beforeFirst() throws SQLException
```

```java
public boolean first() throws SQLException
```

```java
public void cancelRowUpdates() throws SQLException
```

```java
public void deleteRow() throws SQLException
```

```java
public void updateArray(int col, Array x) throws SQLException
```

```java
public void updateArray(String col, Array x) throws SQLException
```

```java
public void updateAsciiStream(int col, InputStream x, int l) throws SQLException
```

```java
public void updateAsciiStream(String col, InputStream x, int l) throws SQLException
```

```java
public void updateBigDecimal(int col, BigDecimal x) throws SQLException
```

```java
public void updateBigDecimal(String col, BigDecimal x) throws SQLException
```

```java
public void updateBinaryStream(int c, InputStream x, int l) throws SQLException
```

```java
public void updateBinaryStream(String c, InputStream x, int l) throws SQLException
```

```java
public void updateBlob(int col, Blob x) throws SQLException
```

```java
public void updateBlob(String col, Blob x) throws SQLException
```

```java
public void updateBoolean(int col, boolean x) throws SQLException
```

```java
public void updateBoolean(String col, boolean x) throws SQLException
```

```java
public void updateByte(int col, byte x) throws SQLException
```

```java
public void updateByte(String col, byte x) throws SQLException
```

```java
public void updateBytes(int col, byte[] x) throws SQLException
```

```java
public void updateBytes(String col, byte[] x) throws SQLException
```

```java
public void updateCharacterStream(int c, Reader x, int l) throws SQLException
```

```java
public void updateCharacterStream(String c, Reader r, int l) throws SQLException
```

```java
public void updateClob(int col, Clob x) throws SQLException
```

```java
public void updateClob(String col, Clob x) throws SQLException
```

```java
public void updateDate(int col, Date x) throws SQLException
```

```java
public void updateDate(String col, Date x) throws SQLException
```

```java
public void updateDouble(int col, double x) throws SQLException
```

```java
public void updateDouble(String col, double x) throws SQLException
```

```java
public void updateFloat(int col, float x) throws SQLException
```

```java
public void updateFloat(String col, float x) throws SQLException
```

```java
public void updateInt(int col, int x) throws SQLException
```

```java
public void updateInt(String col, int x) throws SQLException
```

```java
public void updateLong(int col, long x) throws SQLException
```

```java
public void updateLong(String col, long x) throws SQLException
```

```java
public void updateNull(int col) throws SQLException
```

```java
public void updateNull(String col) throws SQLException
```

```java
public void updateObject(int c, Object x) throws SQLException
```

```java
public void updateObject(int c, Object x, int s) throws SQLException
```

```java
public void updateObject(String col, Object x) throws SQLException
```

```java
public void updateObject(String c, Object x, int s) throws SQLException
```

```java
public void updateRef(int col, Ref x) throws SQLException
```

```java
public void updateRef(String c, Ref x) throws SQLException
```

```java
public void updateRow() throws SQLException
```

```java
public void updateShort(int c, short x) throws SQLException
```

```java
public void updateShort(String c, short x) throws SQLException
```

```java
public void updateString(int c, String x) throws SQLException
```

```java
public void updateString(String c, String x) throws SQLException
```

```java
public void updateTime(int c, Time x) throws SQLException
```

```java
public void updateTime(String c, Time x) throws SQLException
```

```java
public void updateTimestamp(int c, Timestamp x) throws SQLException
```

```java
public void updateTimestamp(String c, Timestamp x) throws SQLException
```

```java
public void refreshRow() throws SQLException
```

```java
public void free() throws SQLException
```

```java
public InputStream getAsciiStream() throws SQLException
```

```java
public Reader getCharacterStream() throws SQLException
```

```java
public Reader getCharacterStream(long arg0, long arg1) throws SQLException
```

```java
public String getSubString(long position, int length) throws SQLException
```

```java
public long length() throws SQLException
```

```java
public long position(String arg0, long arg1) throws SQLException
```

```java
public long position(Clob arg0, long arg1) throws SQLException
```

```java
public OutputStream setAsciiStream(long arg0) throws SQLException
```

```java
public Writer setCharacterStream(long arg0) throws SQLException
```

```java
public int setString(long arg0, String arg1) throws SQLException
```

```java
public int setString(long arg0, String arg1, int arg2, int arg3) throws SQLException
```

```java
public void truncate(long arg0) throws SQLException
```

#### `org/sqlite/jdbc4/JDBC4Statement.java`

```java
public class JDBC4Statement extends JDBC3Statement implements Statement
```

```java
public <T> T unwrap(Class<T> iface) throws ClassCastException
```

```java
public boolean isWrapperFor(Class<?> iface)
```

```java
    @Override
public void close() throws SQLException
```

```java
public boolean isClosed()
```

```java
public void closeOnCompletion() throws SQLException
```

```java
public boolean isCloseOnCompletion() throws SQLException
```

```java
public void setPoolable(boolean poolable) throws SQLException
```

```java
public boolean isPoolable() throws SQLException
```

#### `org/sqlite/util/LibraryLoaderUtil.java`

```java
public class LibraryLoaderUtil
```

```java
public static final String NATIVE_LIB_BASE_NAME = ...
```

> Get the OS-specific resource directory within the jar, where the relevant sqlitejdbc native
> library is located.

```java
public static String getNativeLibResourcePath()
```

> Get the OS-specific name of the sqlitejdbc native library.

```java
public static String getNativeLibName()
```

```java
public static boolean hasNativeLib(String path, String libraryName)
```

#### `org/sqlite/util/OSInfo.java`

> Provides OS name and architecture name.
>
> @author leo

```java
public class OSInfo
```

```java
public static final String X86 = ...
```

```java
public static final String X86_64 = ...
```

```java
public static final String IA64_32 = ...
```

```java
public static final String IA64 = ...
```

```java
public static final String PPC = ...
```

```java
public static final String PPC64 = ...
```

```java
public static final String RISCV64 = ...
```

```java
public static void main(String[] args)
```

```java
public static String getNativeLibFolderPathForCurrentOS()
```

```java
public static String getOSName()
```

```java
public static boolean isAndroid()
```

```java
public static boolean isAndroidRuntime()
```

```java
public static boolean isAndroidTermux()
```

```java
public static boolean isMusl()
```

```java
static String getHardwareName()
```

```java
static String resolveArmArchType()
```

```java
public static String getArchName()
```

```java
static String translateOSNameToFolderName(String osName)
```

```java
static String translateArchNameToFolderName(String archName)
```

#### `org/sqlite/util/ProcessRunner.java`

```java
public class ProcessRunner
```

```java
static String getProcessOutput(Process process) throws IOException
```

#### `org/sqlite/util/QueryUtils.java`

```java
public class QueryUtils
```

> Build a SQLite query using the VALUES clause to return arbitrary values.
>
> @param columns list of column names
> @param valuesList values to return as rows
> @return SQL query as string

```java
public static String valuesQuery(List<String> columns, List<List<Object>> valuesList)
```

#### `org/sqlite/util/ResourceFinder.java`

> Resource address finder for files inside the jar file
>
> @author leo

```java
public class ResourceFinder
```

> Gets the {@link URL} of the file resource
>
> @param referenceClass the base class for finding resources files. This method will search the
> package containing the given referenceClass.
> @param resourceFileName the resource file name relative to the package of the referenceClass
> @return the URL of the file resource

```java
public static URL find(Class<?> referenceClass, String resourceFileName)
```

> Finds the {@link URL} of the resource
>
> @param basePackage the base package to find the resource
> @param resourceFileName the resource file name relative to the package folder
> @return the URL of the specified resource

```java
public static URL find(ClassLoader classLoader, Package basePackage, String resourceFileName)
```

> Finds the {@link URL} of the resource
>
> @param packageName the base package name to find the resource
> @param resourceFileName the resource file name relative to the package folder
> @return the URL of the specified resource

```java
public static URL find(ClassLoader classLoader, String packageName, String resourceFileName)
```

#### `org/sqlite/util/StringUtils.java`

```java
public class StringUtils
```

```java
public static String join(List<String> list, String separator)
```

