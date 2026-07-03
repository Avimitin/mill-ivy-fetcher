# ScalaSql 0.3.1 API Reference
Generated from Maven Central `*-sources.jar` artifacts for the dependency selected in `build.mill`. Adjacent upstream Scaladoc/Javadoc comments are copied when present; implementation bodies are intentionally omitted.

Summary: extracted `1367` non-private declaration signatures from `80` source files.

## Coordinates
- Direct dependency: `com.lihaoyi::scalasql:0.3.1`
- Upstream docs: https://com-lihaoyi.github.io/scalasql/
- Source artifacts included:
  - `com.lihaoyi:scalasql_3:0.3.1`
  - `com.lihaoyi:scalasql-core_3:0.3.1`
  - `com.lihaoyi:scalasql-query_3:0.3.1`
  - `com.lihaoyi:scalasql-operations_3:0.3.1`

## Common imports

```scala
import scalasql.*
import scalasql.SqliteDialect.*
import scalasql.core.SqlStr.SqlStringSyntax
```

## Usage notes

Type-safe SQL query/update DSL. This doc includes the direct dialect façade plus core/query/operations modules where `DbClient`, `Table`, `Column`, `Expr`, `SqlStr`, and query operations are defined.

```scala
import scalasql.*
import scalasql.SqliteDialect.*
import scalasql.core.SqlStr.SqlStringSyntax

case class CachedArtifact[T[_]](
    mavenPath: T[String],
    sha256: T[String],
    size: T[Long]
)
object CachedArtifact extends Table[CachedArtifact]:
  override def tableName = "cached_artifacts"

val dataSource = new org.sqlite.SQLiteDataSource()
dataSource.setUrl("jdbc:sqlite:/tmp/repository.sqlite")

val dbClient = new scalasql.DbClient.DataSource(
  dataSource,
  config = new scalasql.Config {}
)

dbClient.transaction: db =>
  db.updateRaw("CREATE TABLE IF NOT EXISTS cached_artifacts (maven_path TEXT PRIMARY KEY, sha256 TEXT, size INTEGER)")
  db.updateSql(sql"""
    INSERT INTO cached_artifacts (maven_path, sha256, size)
    VALUES (${"com/example/app/1.0.0/app.pom"}, ${"sha256-..."}, ${123L})
  """)
  db.run(CachedArtifact.select.sortBy(_.mavenPath).asc)
```

## API signatures from upstream source

### `com.lihaoyi:scalasql_3:0.3.1`

Source: https://repo1.maven.org/maven2/com/lihaoyi/scalasql_3/0.3.1/scalasql_3-0.3.1-sources.jar

#### `dialects/CompoundSelectRendererForceLimit.scala`

```scala
object CompoundSelectRendererForceLimit
```

```scala
def limitToSqlStr(limit: Option[Int], offset: Option[Int])(implicit tm: TypeMapper[Int]) = ...
```

#### `dialects/DbApiQueryOps.scala`

```scala
class DbApiQueryOps(dialect: DialectTypeMappers)
```

> Creates a SQL `VALUES` clause

```scala
def values[Q, R](ts: Seq[R])(implicit qr: Queryable.Row[Q, R]): Values[Q, R] = ...
```

> Generates a SQL `WITH` common table expression clause

```scala
def withCte[Q, Q2, R, R2](
      lhs: Select[Q, R]
  )(block: Select[Q, R] => Select[Q2, R2])(implicit qr: Queryable.Row[Q2, R2]): Select[Q2, R2] = ...
```

#### `dialects/Dialect.scala`

> Base type for all SQL dialects. A Dialect proides extension methods, extension operators,
> and custom implementations of various query classes that may differ between databases

```scala
trait Dialect extends DialectTypeMappers
```

```scala
implicit val dialectSelf: Dialect = ...
```

```scala
implicit def StringType: TypeMapper[String] = ...
```

```scala
class StringType extends TypeMapper[String]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: String) = ...
```

```scala
implicit def ByteType: TypeMapper[Byte] = ...
```

```scala
class ByteType extends TypeMapper[Byte]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: Byte) = ...
```

```scala
implicit def ShortType: TypeMapper[Short] = ...
```

```scala
class ShortType extends TypeMapper[Short]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: Short) = ...
```

```scala
implicit def IntType: TypeMapper[Int] = ...
```

```scala
class IntType extends TypeMapper[Int]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: Int) = ...
```

```scala
implicit def LongType: TypeMapper[Long] = ...
```

```scala
class LongType extends TypeMapper[Long]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: Long) = ...
```

```scala
implicit def FloatType: TypeMapper[Float] = ...
```

```scala
class FloatType extends TypeMapper[Float]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: Float) = ...
```

```scala
implicit def DoubleType: TypeMapper[Double] = ...
```

```scala
class DoubleType extends TypeMapper[Double]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: Double) = ...
```

```scala
implicit def BigDecimalType: TypeMapper[scala.math.BigDecimal] = ...
```

```scala
class BigDecimalType extends TypeMapper[scala.math.BigDecimal]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: scala.math.BigDecimal) = ...
```

```scala
implicit def BooleanType: TypeMapper[Boolean] = ...
```

```scala
class BooleanType extends TypeMapper[Boolean]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: Boolean) = ...
```

```scala
implicit def UuidType: TypeMapper[UUID] = ...
```

```scala
class UuidType extends TypeMapper[UUID]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: UUID) = ...
```

```scala
implicit def BytesType: TypeMapper[geny.Bytes] = ...
```

```scala
class BytesType extends TypeMapper[geny.Bytes]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: geny.Bytes) = ...
```

```scala
implicit def UtilDateType: TypeMapper[java.util.Date] = ...
```

```scala
class UtilDateType extends TypeMapper[java.util.Date]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: java.util.Date) = ...
```

```scala
implicit def LocalDateType: TypeMapper[LocalDate] = ...
```

```scala
class LocalDateType extends TypeMapper[LocalDate]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: LocalDate) = ...
```

```scala
implicit def LocalTimeType: TypeMapper[LocalTime] = ...
```

```scala
class LocalTimeType extends TypeMapper[LocalTime]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: LocalTime) = ...
```

```scala
implicit def LocalDateTimeType: TypeMapper[LocalDateTime] = ...
```

```scala
class LocalDateTimeType extends TypeMapper[LocalDateTime]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: LocalDateTime) = ...
```

```scala
implicit def ZonedDateTimeType: TypeMapper[ZonedDateTime] = ...
```

```scala
class ZonedDateTimeType extends TypeMapper[ZonedDateTime]
```

```scala
def jdbcType = ...
```

```scala
override def castTypeString = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: ZonedDateTime) = ...
```

```scala
implicit def InstantType: TypeMapper[Instant] = ...
```

```scala
class InstantType extends TypeMapper[Instant]
```

```scala
def jdbcType = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: Instant) = ...
```

```scala
implicit def OffsetTimeType: TypeMapper[OffsetTime] = ...
```

```scala
class OffsetTimeType extends TypeMapper[OffsetTime]
```

```scala
def jdbcType = ...
```

```scala
override def castTypeString = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: OffsetTime) = ...
```

```scala
implicit def OffsetDateTimeType: TypeMapper[OffsetDateTime] = ...
```

```scala
class OffsetDateTimeType extends TypeMapper[OffsetDateTime]
```

```scala
def jdbcType = ...
```

```scala
override def castTypeString = ...
```

```scala
def get(r: ResultSet, idx: Int) = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: OffsetDateTime) = ...
```

```scala
implicit def EnumType[T <: Enumeration#Value](implicit constructor: String => T): TypeMapper[T] = ...
```

```scala
class EnumType[T](implicit constructor: String => T) extends TypeMapper[T]
```

```scala
def jdbcType: JDBCType = ...
```

```scala
def get(r: ResultSet, idx: Int): T = ...
```

```scala
def put(r: PreparedStatement, idx: Int, v: T) = ...
```

```scala
implicit def from(x: Byte): Expr[Byte] = ...
```

```scala
implicit def from(x: Short): Expr[Short] = ...
```

```scala
implicit def from(x: Int): Expr[Int] = ...
```

```scala
implicit def from(x: Long): Expr[Long] = ...
```

```scala
implicit def from(x: Boolean): Expr[Boolean] = ...
```

```scala
implicit def from(x: Float): Expr[Float] = ...
```

```scala
implicit def from(x: Double): Expr[Double] = ...
```

```scala
implicit def from(x: scala.math.BigDecimal): Expr[scala.math.BigDecimal] = ...
```

```scala
implicit def from(x: String): Expr[String] = ...
```

```scala
implicit def OptionType[T](implicit inner: TypeMapper[T]): TypeMapper[Option[T]] = ...
```

```scala
implicit def ExprBooleanOpsConv(v: Expr[Boolean]): operations.ExprBooleanOps = ...
```

```scala
implicit def ExprNumericOpsConv[T: Numeric: TypeMapper](
      v: Expr[T]
  ): operations.ExprNumericOps[T] = ...
```

```scala
implicit def ExprOpsConv[T](v: Expr[T]): operations.ExprOps[T] = ...
```

```scala
implicit def ExprTypedOpsConv[T: ClassTag](v: Expr[T]): operations.ExprTypedOps[T] = ...
```

```scala
implicit def ExprOptionOpsConv[T: TypeMapper](v: Expr[Option[T]]): operations.ExprOptionOps[T] = ...
```

```scala
implicit def JoinNullableOpsConv[T: TypeMapper](
      v: JoinNullable[Expr[T]]
  ): operations.ExprOps[Option[T]] = ...
```

```scala
implicit def JoinNullableOptionOpsConv[T: TypeMapper](
      v: JoinNullable[Expr[T]]
  ): operations.ExprOptionOps[T] = ...
```

```scala
implicit def ExprStringOpsConv(
      v: Expr[String]
  ): operations.ExprStringLikeOps[String] & operations.ExprStringOps[String]
```

```scala
implicit def ExprBlobOpsConv(v: Expr[geny.Bytes]): operations.ExprStringLikeOps[geny.Bytes]
```

```scala
implicit def AggNumericOpsConv[V: Numeric: TypeMapper](v: Aggregatable[Expr[V]])(
      implicit qr: Queryable.Row[Expr[V], V]
  ): operations.AggNumericOps[V] = ...
```

```scala
implicit def AggOpsConv[T](v: Aggregatable[T])(
      implicit qr: Queryable.Row[T, ?]
  ): operations.AggOps[T] = ...
```

```scala
implicit def AggAnyOpsConv[T: TypeMapper](v: Aggregatable[Expr[T]])(
      implicit qrInt: Queryable.Row[Expr[Int], Int]
  ): operations.AggAnyOps[T] = ...
```

```scala
implicit def ExprAggOpsConv[T](v: Aggregatable[Expr[T]]): operations.ExprAggOps[T]
```

```scala
implicit def TableOpsConv[V[_[_]]](t: Table[V]): TableOps[V] = ...
```

```scala
implicit def DbApiQueryOpsConv(db: => DbApi): DbApiQueryOps = ...
```

```scala
implicit def DbApiOpsConv(db: => DbApi): DbApiOps = ...
```

```scala
implicit class WindowExtensions[T](e: Expr[T])
```

```scala
def over = ...
```

```scala
implicit def ExprQueryable[T](implicit mt: TypeMapper[T]): Queryable.Row[Expr[T], T] = ...
```

#### `dialects/H2Dialect.scala`

```scala
trait H2Dialect extends Dialect
```

```scala
def castParams = ...
```

```scala
def escape(str: String) = ...
```

```scala
def supportSavepointRelease = ...
```

```scala
override implicit def EnumType[T <: Enumeration#Value](
      implicit constructor: String => T
  ): TypeMapper[T] = ...
```

```scala
class H2EnumType[T](implicit constructor: String => T) extends EnumType[T]
```

```scala
override def put(r: PreparedStatement, idx: Int, v: T): Unit = ...
```

```scala
override implicit def ExprStringOpsConv(v: Expr[String]): H2Dialect.ExprStringOps[String] = ...
```

```scala
override implicit def ExprBlobOpsConv(
      v: Expr[geny.Bytes]
  ): H2Dialect.ExprStringLikeOps[geny.Bytes] = ...
```

```scala
override implicit def ExprNumericOpsConv[T: Numeric: TypeMapper](
      v: Expr[T]
  ): H2Dialect.ExprNumericOps[T] = ...
```

```scala
override implicit def TableOpsConv[V[_[_]]](t: Table[V]): scalasql.dialects.TableOps[V] = ...
```

```scala
override implicit def DbApiQueryOpsConv(db: => DbApi): DbApiQueryOps = ...
```

```scala
implicit def ExprAggOpsConv[T](v: Aggregatable[Expr[T]]): operations.ExprAggOps[T] = ...
```

```scala
override implicit def DbApiOpsConv(db: => DbApi): H2Dialect.DbApiOps = ...
```

```scala
object H2Dialect extends H2Dialect
```

```scala
override def supportSavepointRelease: Boolean = ...
```

```scala
class DbApiOps(dialect: DialectTypeMappers)
```

```scala
class ExprAggOps[T](v: Aggregatable[Expr[T]]) extends scalasql.operations.ExprAggOps[T](v)
```

```scala
def mkString(sep: Expr[String] = null)(implicit tm: TypeMapper[T]): Expr[String] = ...
```

```scala
class ExprStringOps[T](v: Expr[T]) extends ExprStringLikeOps(v) with operations.ExprStringOps[T]
```

```scala
class ExprStringLikeOps[T](protected val v: Expr[T])
```

```scala
def indexOf(x: Expr[T]): Expr[Int] = ...
```

```scala
class ExprNumericOps[T: Numeric: TypeMapper](protected val v: Expr[T])
```

```scala
def power(y: Expr[T]): Expr[T] = ...
```

```scala
class TableOps[V[_[_]]](t: Table[V]) extends scalasql.dialects.TableOps[V](t)
```

```scala
trait Select[Q, R] extends scalasql.query.Select[Q, R]
```

```scala
override def newCompoundSelect[Q, R](
        lhs: scalasql.query.SimpleSelect[Q, R],
        compoundOps: Seq[CompoundSelect.Op[Q, R]],
        orderBy: Seq[OrderBy],
        limit: Option[Int],
        offset: Option[Int]
    )(
        implicit qr: Queryable.Row[Q, R],
        dialect: scalasql.core.DialectTypeMappers
    ): scalasql.query.CompoundSelect[Q, R] = ...
```

```scala
override def newSimpleSelect[Q, R](
        expr: Q,
        exprPrefix: Option[Context => SqlStr],
        exprSuffix: Option[Context => SqlStr],
        preserveAll: Boolean,
        from: Seq[Context.From],
        joins: Seq[Join],
        where: Seq[Expr[?]],
        groupBy0: Option[GroupBy]
    )(
        implicit qr: Queryable.Row[Q, R],
        dialect: scalasql.core.DialectTypeMappers
    ): scalasql.query.SimpleSelect[Q, R] = ...
```

```scala
class SimpleSelect[Q, R](
      expr: Q,
      exprPrefix: Option[Context => SqlStr],
      exprSuffix: Option[Context => SqlStr],
      preserveAll: Boolean,
      from: Seq[Context.From],
      joins: Seq[Join],
      where: Seq[Expr[?]],
      groupBy0: Option[GroupBy]
  )(implicit qr: Queryable.Row[Q, R])
```

```scala
override def outerJoin[Q2, R2](other: Joinable[Q2, R2])(on: (Q, Q2) => Expr[Boolean])(
        implicit joinQr: Queryable.Row[Q2, R2]
    ): scalasql.query.Select[(JoinNullable[Q], JoinNullable[Q2]), (Option[R], Option[R2])] = ...
```

```scala
class CompoundSelect[Q, R](
      lhs: scalasql.query.SimpleSelect[Q, R],
      compoundOps: Seq[scalasql.query.CompoundSelect.Op[Q, R]],
      orderBy: Seq[OrderBy],
      limit: Option[Int],
      offset: Option[Int]
  )(implicit qr: Queryable.Row[Q, R])
```

```scala
class Values[Q, R](ts: Seq[R])(implicit qr: Queryable.Row[Q, R])
```

#### `dialects/MsSqlDialect.scala`

```scala
trait MsSqlDialect extends Dialect
```

```scala
def castParams = ...
```

```scala
def escape(str: String): String = ...
```

```scala
def supportSavepointRelease = ...
```

```scala
override implicit def IntType: TypeMapper[Int] = ...
```

```scala
class MsSqlIntType extends IntType
```

```scala
override implicit def StringType: TypeMapper[String] = ...
```

```scala
class MsSqlStringType extends StringType
```

```scala
override implicit def BooleanType: TypeMapper[Boolean] = ...
```

```scala
class MsSqlBooleanType extends BooleanType
```

```scala
override implicit def ExprOptionOpsConv[T: TypeMapper](
      v: Expr[Option[T]]
  ): operations.ExprOptionOps[T] = ...
```

```scala
class MsSqlBooleanExprOptionOps(v: Expr[Option[Boolean]])
```

```scala
override def getOrElse(other: Expr[Boolean]): Expr[Boolean] = ...
```

```scala
override implicit def from(x: Boolean): Expr[Boolean] = ...
```

```scala
override implicit def DoubleType: TypeMapper[Double] = ...
```

```scala
class MsDoubleType extends DoubleType
```

```scala
override implicit def OptionType[T](implicit inner: TypeMapper[T]): TypeMapper[Option[T]] = ...
```

```scala
override implicit def UtilDateType: TypeMapper[java.util.Date] = ...
```

```scala
class MsSqlUtilDateType extends UtilDateType
```

```scala
override implicit def LocalDateTimeType: TypeMapper[LocalDateTime] = ...
```

```scala
class MsSqlLocalDateTimeType extends LocalDateTimeType
```

```scala
override def castTypeString = ...
```

```scala
override implicit def InstantType: TypeMapper[Instant] = ...
```

```scala
class MsSqlInstantType extends InstantType
```

```scala
override implicit def ZonedDateTimeType: TypeMapper[ZonedDateTime] = ...
```

```scala
class MsSqlZonedDateTimeType extends ZonedDateTimeType
```

```scala
override def castTypeString = ...
```

```scala
override def get(r: ResultSet, idx: Int) = ...
```

```scala
override def put(r: PreparedStatement, idx: Int, v: ZonedDateTime) = ...
```

```scala
override implicit def OffsetDateTimeType: TypeMapper[OffsetDateTime] = ...
```

```scala
class MsSqlOffsetDateTimeType extends OffsetDateTimeType
```

```scala
override def castTypeString = ...
```

```scala
override def get(r: ResultSet, idx: Int) = ...
```

```scala
override def put(r: PreparedStatement, idx: Int, v: OffsetDateTime) = ...
```

```scala
override implicit def EnumType[T <: Enumeration#Value](
      implicit constructor: String => T
  ): TypeMapper[T] = ...
```

```scala
class MsSqlEnumType[T](implicit constructor: String => T) extends EnumType[T]
```

```scala
override def put(r: PreparedStatement, idx: Int, v: T): Unit = ...
```

```scala
override implicit def ExprStringOpsConv(v: Expr[String]): MsSqlDialect.ExprStringOps[String] = ...
```

```scala
override implicit def ExprBlobOpsConv(
      v: Expr[geny.Bytes]
  ): MsSqlDialect.ExprStringLikeOps[geny.Bytes] = ...
```

```scala
override implicit def ExprNumericOpsConv[T: Numeric: TypeMapper](
      v: Expr[T]
  ): MsSqlDialect.ExprNumericOps[T] = ...
```

```scala
override implicit def TableOpsConv[V[_[_]]](t: Table[V]): scalasql.dialects.TableOps[V] = ...
```

```scala
implicit def ExprAggOpsConv[T](v: Aggregatable[Expr[T]]): operations.ExprAggOps[T] = ...
```

```scala
override implicit def DbApiOpsConv(db: => DbApi): MsSqlDialect.DbApiOps = ...
```

```scala
override implicit def ExprQueryable[T](implicit mt: TypeMapper[T]): Queryable.Row[Expr[T], T] = ...
```

```scala
object MsSqlDialect extends MsSqlDialect
```

```scala
class DbApiOps(dialect: DialectTypeMappers)
```

```scala
override def ln[T: Numeric](v: Expr[T]): Expr[Double] = ...
```

```scala
override def atan2[T: Numeric](v: Expr[T], y: Expr[T]): Expr[Double] = ...
```

```scala
class ExprAggOps[T](v: Aggregatable[Expr[T]]) extends scalasql.operations.ExprAggOps[T](v)
```

```scala
def mkString(sep: Expr[String] = null)(implicit tm: TypeMapper[T]): Expr[String] = ...
```

```scala
class ExprStringOps[T](v: Expr[T]) extends ExprStringLikeOps(v) with operations.ExprStringOps[T]
```

```scala
class ExprStringLikeOps[T](protected val v: Expr[T])
```

```scala
override def +(x: Expr[T]): Expr[T] = ...
```

```scala
override def startsWith(other: Expr[T]): Expr[Boolean] = ...
```

```scala
override def endsWith(other: Expr[T]): Expr[Boolean] = ...
```

```scala
override def contains(other: Expr[T]): Expr[Boolean] = ...
```

```scala
override def length: Expr[Int] = ...
```

```scala
override def octetLength: Expr[Int] = ...
```

```scala
def indexOf(x: Expr[T]): Expr[Int] = ...
```

```scala
def reverse: Expr[T] = ...
```

```scala
class ExprNumericOps[T: Numeric: TypeMapper](protected val v: Expr[T])
```

```scala
override def %[V: Numeric](x: Expr[V]): Expr[T] = ...
```

```scala
override def mod[V: Numeric](x: Expr[V]): Expr[T] = ...
```

```scala
override def ceil: Expr[T] = ...
```

```scala
class TableOps[V[_[_]]](t: Table[V]) extends scalasql.dialects.TableOps[V](t)
```

```scala
trait Select[Q, R] extends scalasql.query.Select[Q, R]
```

```scala
override def newCompoundSelect[Q, R](
        lhs: scalasql.query.SimpleSelect[Q, R],
        compoundOps: Seq[scalasql.query.CompoundSelect.Op[Q, R]],
        orderBy: Seq[OrderBy],
        limit: Option[Int],
        offset: Option[Int]
    )(
        implicit qr: Queryable.Row[Q, R],
        dialect: scalasql.core.DialectTypeMappers
    ): scalasql.query.CompoundSelect[Q, R] = ...
```

```scala
override def newSimpleSelect[Q, R](
        expr: Q,
        exprPrefix: Option[Context => SqlStr],
        exprSuffix: Option[Context => SqlStr],
        preserveAll: Boolean,
        from: Seq[Context.From],
        joins: Seq[Join],
        where: Seq[Expr[?]],
        groupBy0: Option[GroupBy]
    )(
        implicit qr: Queryable.Row[Q, R],
        dialect: scalasql.core.DialectTypeMappers
    ): scalasql.query.SimpleSelect[Q, R] = ...
```

```scala
class SimpleSelect[Q, R](
      expr: Q,
      exprPrefix: Option[Context => SqlStr],
      exprSuffix: Option[Context => SqlStr],
      preserveAll: Boolean,
      from: Seq[Context.From],
      joins: Seq[Join],
      where: Seq[Expr[?]],
      groupBy0: Option[GroupBy]
  )(implicit qr: Queryable.Row[Q, R])
```

```scala
override def take(n: Int): scalasql.query.Select[Q, R] = ...
```

```scala
override def drop(n: Int): scalasql.query.Select[Q, R] = ...
```

```scala
class CompoundSelect[Q, R](
      lhs: scalasql.query.SimpleSelect[Q, R],
      compoundOps: Seq[scalasql.query.CompoundSelect.Op[Q, R]],
      orderBy: Seq[OrderBy],
      limit: Option[Int],
      offset: Option[Int]
  )(implicit qr: Queryable.Row[Q, R])
```

```scala
override def take(n: Int): scalasql.query.Select[Q, R] = ...
```

```scala
class CompoundSelectRenderer[Q, R](
      query: scalasql.query.CompoundSelect[Q, R],
      prevContext: Context
  ) extends scalasql.query.CompoundSelect.Renderer(query, prevContext)
```

```scala
override lazy val limitOpt = ...
```

```scala
override lazy val offsetOpt = ...
```

```scala
override def render(liveExprs: LiveExprs): SqlStr = ...
```

```scala
override def orderToSqlStr(newCtx: Context) = ...
```

```scala
class ExprQueryable[E[_] <: Expr[?], T](
      implicit tm: TypeMapper[T]
  ) extends Expr.ExprQueryable[E, T]
```

```scala
override def walkExprs(q: E[T]): Seq[Expr[?]] = ...
```

#### `dialects/MySqlDialect.scala`

```scala
trait MySqlDialect extends Dialect
```

```scala
def castParams = ...
```

```scala
def escape(str: String) = ...
```

```scala
def supportSavepointRelease = ...
```

```scala
override implicit def ByteType: TypeMapper[Byte] = ...
```

```scala
class MySqlByteType extends ByteType
```

```scala
override implicit def ShortType: TypeMapper[Short] = ...
```

```scala
class MySqlShortType extends ShortType
```

```scala
override implicit def IntType: TypeMapper[Int] = ...
```

```scala
class MySqlIntType extends IntType
```

```scala
override implicit def LongType: TypeMapper[Long] = ...
```

```scala
class MySqlLongType extends LongType
```

```scala
override implicit def StringType: TypeMapper[String] = ...
```

```scala
class MySqlStringType extends StringType
```

```scala
override implicit def LocalDateTimeType: TypeMapper[LocalDateTime] = ...
```

```scala
class MySqlLocalDateTimeType extends LocalDateTimeType
```

```scala
override def castTypeString = ...
```

```scala
override implicit def InstantType: TypeMapper[Instant] = ...
```

```scala
class MySqlInstantType extends InstantType
```

```scala
override implicit def UtilDateType: TypeMapper[java.util.Date] = ...
```

```scala
class MySqlUtilDateType extends UtilDateType
```

```scala
override implicit def UuidType: TypeMapper[UUID] = ...
```

```scala
class MySqlUuidType extends UuidType
```

```scala
override def put(r: PreparedStatement, idx: Int, v: UUID) = ...
```

```scala
override implicit def EnumType[T <: Enumeration#Value](
      implicit constructor: String => T
  ): TypeMapper[T] = ...
```

```scala
class MySqlEnumType[T](implicit constructor: String => T) extends EnumType[T]
```

```scala
override def put(r: PreparedStatement, idx: Int, v: T): Unit = ...
```

```scala
override implicit def ExprTypedOpsConv[T: ClassTag](v: Expr[T]): operations.ExprTypedOps[T] = ...
```

```scala
override implicit def ExprStringOpsConv(v: Expr[String]): MySqlDialect.ExprStringOps[String] = ...
```

```scala
override implicit def ExprBlobOpsConv(
      v: Expr[geny.Bytes]
  ): MySqlDialect.ExprStringLikeOps[geny.Bytes] = ...
```

```scala
override implicit def TableOpsConv[V[_[_]]](t: Table[V]): scalasql.dialects.TableOps[V] = ...
```

```scala
implicit def OnConflictableUpdate[V[_[_]], R](
      query: InsertColumns[V, R]
  ): MySqlDialect.OnConflictable[V[Column], Int] = ...
```

```scala
override implicit def DbApiQueryOpsConv(db: => DbApi): DbApiQueryOps = ...
```

```scala
implicit def LateralJoinOpsConv[C[_, _], Q, R](wrapped: JoinOps[C, Q, R] & Joinable[Q, R])(
      implicit qr: Queryable.Row[Q, R]
  ): LateralJoinOps[C, Q, R] = ...
```

```scala
implicit def ExprAggOpsConv[T](v: Aggregatable[Expr[T]]): operations.ExprAggOps[T] = ...
```

```scala
implicit class SelectForUpdateConv[Q, R](r: Select[Q, R])
```

> SELECT .. FOR UPDATE acquires an exclusive lock, blocking other transactions from
> modifying or locking the selected rows, which is for managing concurrent transactions
> and ensuring data consistency in multi-step operations.

```scala
def forUpdate: Select[Q, R] = ...
```

> SELECT ... FOR SHARE: Locks the selected rows for reading, allowing other transactions
> to read but not modify the locked rows

```scala
def forShare: Select[Q, R] = ...
```

> SELECT ... FOR UPDATE NOWAIT: Immediately returns an error if the selected rows are
> already locked, instead of waiting

```scala
def forUpdateNoWait: Select[Q, R] = ...
```

> SELECT ... FOR UPDATE SKIP LOCKED: Skips any rows that are already locked by other
> transactions, instead of waiting

```scala
def forUpdateSkipLocked: Select[Q, R] = ...
```

```scala
override implicit def DbApiOpsConv(db: => DbApi): MySqlDialect.DbApiOps = ...
```

```scala
object MySqlDialect extends MySqlDialect
```

```scala
override def supportSavepointRelease: Boolean = ...
```

```scala
class DbApiOps(dialect: DialectTypeMappers)
```

> Returns a random value in the range 0.0 <= x < 1.0

```scala
def rand: Expr[Double] = ...
```

```scala
class ExprAggOps[T](v: Aggregatable[Expr[T]]) extends scalasql.operations.ExprAggOps[T](v)
```

```scala
def mkString(sep: Expr[String] = null)(implicit tm: TypeMapper[T]): Expr[String] = ...
```

```scala
class ExprTypedOps[T: ClassTag](v: Expr[T]) extends operations.ExprTypedOps(v)
```

> Equals to

```scala
override def = ...
```

> Not equal to

```scala
override def ! = ...
```

```scala
class ExprStringOps[T](v: Expr[T]) extends ExprStringLikeOps(v) with operations.ExprStringOps[T]
```

```scala
class ExprStringLikeOps[T](protected val v: Expr[T])
```

```scala
override def +(x: Expr[T]): Expr[T] = ...
```

```scala
override def startsWith(other: Expr[T]): Expr[Boolean] = ...
```

```scala
override def endsWith(other: Expr[T]): Expr[Boolean] = ...
```

```scala
override def contains(other: Expr[T]): Expr[Boolean] = ...
```

```scala
def indexOf(x: Expr[T]): Expr[Int] = ...
```

```scala
def reverse: Expr[T] = ...
```

```scala
class TableOps[V[_[_]]](t: Table[V]) extends scalasql.dialects.TableOps[V](t)
```

```scala
override def update(
        filter: V[Column] => Expr[Boolean]
    ): Update[V[Column], V[Sc]] = ...
```

```scala
class Update[Q, R](
      expr: Q,
      table: TableRef,
      set0: Seq[Column.Assignment[?]],
      joins: Seq[Join],
      where: Seq[Expr[?]]
  )(implicit qr: Queryable.Row[Q, R])
```

```scala
class UpdateRenderer(
      joins0: Seq[Join],
      table: TableRef,
      set0: Seq[Column.Assignment[?]],
      where0: Seq[Expr[?]],
      prevContext: Context
  ) extends scalasql.query.Update.Renderer(joins0, table, set0, where0, prevContext)
```

```scala
override lazy val updateList = ...
```

```scala
lazy val whereAll = ...
```

```scala
override lazy val joinOns = ...
```

```scala
override lazy val joins = ...
```

```scala
override def render() = ...
```

```scala
class OnConflictable[Q, R](val query: Query[R], expr: Q, table: TableRef)
```

```scala
def onConflictUpdate(c2: Q => Column.Assignment[?]*): OnConflictUpdate[Q, R] = ...
```

```scala
class OnConflictUpdate[Q, R](
      insert: OnConflictable[Q, R],
      updates: Seq[Column.Assignment[?]],
      table: TableRef
  ) extends Query.DelegateQuery[R]
```

```scala
override def queryIsExecuteUpdate = ...
```

```scala
trait Select[Q, R] extends scalasql.query.Select[Q, R]
```

```scala
override def newCompoundSelect[Q, R](
        lhs: scalasql.query.SimpleSelect[Q, R],
        compoundOps: Seq[CompoundSelect.Op[Q, R]],
        orderBy: Seq[OrderBy],
        limit: Option[Int],
        offset: Option[Int]
    )(
        implicit qr: Queryable.Row[Q, R],
        dialect: scalasql.core.DialectTypeMappers
    ): scalasql.query.CompoundSelect[Q, R] = ...
```

```scala
override def newSimpleSelect[Q, R](
        expr: Q,
        exprPrefix: Option[Context => SqlStr],
        exprSuffix: Option[Context => SqlStr],
        preserveAll: Boolean,
        from: Seq[Context.From],
        joins: Seq[Join],
        where: Seq[Expr[?]],
        groupBy0: Option[GroupBy]
    )(
        implicit qr: Queryable.Row[Q, R],
        dialect: scalasql.core.DialectTypeMappers
    ): scalasql.query.SimpleSelect[Q, R] = ...
```

```scala
class SimpleSelect[Q, R](
      expr: Q,
      exprPrefix: Option[Context => SqlStr],
      exprSuffix: Option[Context => SqlStr],
      preserveAll: Boolean,
      from: Seq[Context.From],
      joins: Seq[Join],
      where: Seq[Expr[?]],
      groupBy0: Option[GroupBy]
  )(implicit qr: Queryable.Row[Q, R])
```

```scala
override def outerJoin[Q2, R2](other: Joinable[Q2, R2])(on: (Q, Q2) => Expr[Boolean])(
        implicit joinQr: Queryable.Row[Q2, R2]
    ): scalasql.query.Select[(JoinNullable[Q], JoinNullable[Q2]), (Option[R], Option[R2])] = ...
```

```scala
class CompoundSelect[Q, R](
      lhs: scalasql.query.SimpleSelect[Q, R],
      compoundOps: Seq[scalasql.query.CompoundSelect.Op[Q, R]],
      orderBy: Seq[OrderBy],
      limit: Option[Int],
      offset: Option[Int]
  )(implicit qr: Queryable.Row[Q, R])
```

```scala
class CompoundSelectRenderer[Q, R](
      query: scalasql.query.CompoundSelect[Q, R],
      prevContext: Context
  ) extends scalasql.query.CompoundSelect.Renderer(query, prevContext)
```

```scala
override lazy val limitOpt = ...
```

```scala
override def orderToSqlStr(newCtx: Context) = ...
```

```scala
class Values[Q, R](ts: Seq[R])(implicit qr: Queryable.Row[Q, R])
```

```scala
class ValuesRenderer[Q, R](v: Values[Q, R])(implicit qr: Queryable.Row[Q, R], ctx: Context)
```

```scala
override def wrapRow(t: R): SqlStr = ...
```

#### `dialects/OnConflictOps.scala`

```scala
trait OnConflictOps
```

```scala
implicit def OnConflictableInsertColumns[V[_[_]], R](
      query: InsertColumns[V, R]
  ): OnConflict[V[Column], Int] = ...
```

```scala
implicit def OnConflictableInsertValues[V[_[_]], R](
      query: InsertValues[V, R]
  ): OnConflict[V[Column], Int] = ...
```

```scala
implicit def OnConflictableInsertSelect[V[_[_]], C, R, R2](
      query: InsertSelect[V, C, R, R2]
  ): OnConflict[V[Column], Int] = ...
```

#### `dialects/PostgresDialect.scala`

```scala
trait PostgresDialect extends Dialect with ReturningDialect with OnConflictOps
```

```scala
def castParams = ...
```

```scala
def escape(str: String) = ...
```

```scala
def supportSavepointRelease = ...
```

```scala
override implicit def ByteType: TypeMapper[Byte] = ...
```

```scala
class PostgresByteType extends ByteType
```

```scala
override implicit def StringType: TypeMapper[String] = ...
```

```scala
class PostgresStringType extends StringType
```

```scala
override implicit def ExprStringOpsConv(v: Expr[String]): PostgresDialect.ExprStringOps[String] = ...
```

```scala
override implicit def ExprBlobOpsConv(
      v: Expr[geny.Bytes]
  ): PostgresDialect.ExprStringLikeOps[geny.Bytes] = ...
```

```scala
implicit def LateralJoinOpsConv[C[_, _], Q, R](wrapped: JoinOps[C, Q, R] & Joinable[Q, R])(
      implicit qr: Queryable.Row[Q, R]
  ): LateralJoinOps[C, Q, R] = ...
```

```scala
implicit def ExprAggOpsConv[T](v: Aggregatable[Expr[T]]): operations.ExprAggOps[T] = ...
```

```scala
implicit class SelectDistinctOnConv[Q, R](r: Select[Q, R])
```

> SELECT DISTINCT ON ( expression [, ...] ) keeps only the first row of each set of rows
> where the given expressions evaluate to equal. The DISTINCT ON expressions are
> interpreted using the same rules as for ORDER BY (see above). Note that the “first
> row” of each set is unpredictable unless ORDER BY is used to ensure that the desired
> row appears first. For example:

```scala
def distinctOn(one: Q => Expr[?], more: (Q => Expr[?])*): Select[Q, R] = ...
```

```scala
implicit class SelectForUpdateConv[Q, R](r: Select[Q, R])
```

> SELECT .. FOR UPDATE acquires an exclusive lock, blocking other transactions from
> modifying or locking the selected rows, which is for managing concurrent transactions
> and ensuring data consistency in multi-step operations.

```scala
def forUpdate: Select[Q, R] = ...
```

> SELECT ... FOR NO KEY UPDATE: A weaker lock that doesn't block inserts into child
> tables with foreign key references

```scala
def forNoKeyUpdate: Select[Q, R] = ...
```

> SELECT ... FOR SHARE: Locks the selected rows for reading, allowing other transactions
> to read but not modify the locked rows.

```scala
def forShare: Select[Q, R] = ...
```

> SELECT ... FOR KEY SHARE: The weakest lock, only conflicts with FOR UPDATE

```scala
def forKeyShare: Select[Q, R] = ...
```

> SELECT ... FOR UPDATE NOWAIT: Immediately returns an error if the selected rows are
> already locked, instead of waiting

```scala
def forUpdateNoWait: Select[Q, R] = ...
```

> SELECT ... FOR UPDATE SKIP LOCKED: Skips any rows that are already locked by other
> transactions, instead of waiting

```scala
def forUpdateSkipLocked: Select[Q, R] = ...
```

```scala
override implicit def DbApiOpsConv(db: => DbApi): PostgresDialect.DbApiOps = ...
```

```scala
object PostgresDialect extends PostgresDialect
```

```scala
class DbApiOps(dialect: DialectTypeMappers)
```

> Formats arguments according to a format string. This function is similar to the C function sprintf.

```scala
def format(template: Expr[String], values: Expr[?]*): Expr[String] = ...
```

> Returns a random value in the range 0.0 <= x < 1.0

```scala
def random: Expr[Double] = ...
```

```scala
class ExprAggOps[T](v: Aggregatable[Expr[T]]) extends scalasql.operations.ExprAggOps[T](v)
```

```scala
def mkString(sep: Expr[String] = null)(implicit tm: TypeMapper[T]): Expr[String] = ...
```

```scala
class ExprStringOps[T](v: Expr[T]) extends ExprStringLikeOps(v) with operations.ExprStringOps[T]
```

```scala
class ExprStringLikeOps[T](protected val v: Expr[T])
```

```scala
def indexOf(x: Expr[T]): Expr[Int] = ...
```

```scala
def reverse: Expr[T] = ...
```

#### `dialects/ReturningDialect.scala`

```scala
trait ReturningDialect extends Dialect
```

```scala
implicit class InsertReturningConv[Q](r: Returning.InsertBase[Q])
```

```scala
def returning[Q2, R](f: Q => Q2)(implicit qr: Queryable.Row[Q2, R]): Returning[Q2, R] = ...
```

```scala
implicit class ReturningConv[Q](r: Returning.Base[Q])
```

```scala
def returning[Q2, R](f: Q => Q2)(implicit qr: Queryable.Row[Q2, R]): Returning[Q2, R] = ...
```

```scala
implicit class OnConflictUpdateConv[Q, R](r: OnConflict.Update[Q, R])
```

```scala
def returning[Q2, R](f: Q => Q2)(implicit qr: Queryable.Row[Q2, R]): Returning[Q2, R] = ...
```

```scala
implicit class OnConflictIgnoreConv[Q, R](r: OnConflict.Ignore[Q, R])
```

```scala
def returning[Q2, R](f: Q => Q2)(implicit qr: Queryable.Row[Q2, R]): Returning[Q2, R] = ...
```

#### `dialects/SqliteDialect.scala`

```scala
trait SqliteDialect extends Dialect with ReturningDialect with OnConflictOps
```

```scala
def castParams = ...
```

```scala
def escape(str: String) = ...
```

```scala
def supportSavepointRelease = ...
```

```scala
override implicit def LocalDateTimeType: TypeMapper[LocalDateTime] = ...
```

```scala
class SqliteLocalDateTimeType extends LocalDateTimeType
```

```scala
override def castTypeString = ...
```

```scala
override implicit def LocalDateType: TypeMapper[LocalDate] = ...
```

```scala
class SqliteLocalDateType extends LocalDateType
```

```scala
override implicit def InstantType: TypeMapper[Instant] = ...
```

```scala
class SqliteInstantType extends InstantType
```

```scala
override implicit def UtilDateType: TypeMapper[java.util.Date] = ...
```

```scala
class SqliteUtilDateType extends UtilDateType
```

```scala
override implicit def ExprStringOpsConv(v: Expr[String]): SqliteDialect.ExprStringOps[String] = ...
```

```scala
override implicit def ExprBlobOpsConv(
      v: Expr[geny.Bytes]
  ): SqliteDialect.ExprStringLikeOps[geny.Bytes] = ...
```

```scala
override implicit def TableOpsConv[V[_[_]]](t: Table[V]): scalasql.dialects.TableOps[V] = ...
```

```scala
implicit def ExprAggOpsConv[T](v: Aggregatable[Expr[T]]): operations.ExprAggOps[T] = ...
```

```scala
override implicit def DbApiOpsConv(db: => DbApi): SqliteDialect.DbApiOps = ...
```

```scala
object SqliteDialect extends SqliteDialect
```

```scala
override def supportSavepointRelease: Boolean = ...
```

```scala
class DbApiOps(dialect: DialectTypeMappers) extends scalasql.operations.DbApiOps(dialect)
```

> The changes() function returns the number of database rows that were changed
> or inserted or deleted by the most recently completed INSERT, DELETE, or
> UPDATE statement, exclusive of statements in lower-level triggers. The
> changes() SQL function is a wrapper around the sqlite3_changes64() C/C++
> function and hence follows the same rules for counting changes.

```scala
def changes: Expr[Int] = ...
```

> The total_changes() function returns the number of row changes caused by
> INSERT, UPDATE or DELETE statements since the current database connection
> was opened. This function is a wrapper around the sqlite3_total_changes64()
> C/C++ interface.

```scala
def totalChanges: Expr[Int] = ...
```

> The typeof(X) function returns a string that indicates the datatype of the
> expression X: "null", "integer", "real", "text", or "blob".

```scala
def typeOf(v: Expr[?]): Expr[String] = ...
```

> The last_insert_rowid() function returns the ROWID of the last row insert
> from the database connection which invoked the function. The
> last_insert_rowid() SQL function is a wrapper around the
> sqlite3_last_insert_rowid() C/C++ interface function.

```scala
def lastInsertRowId: Expr[Int] = ...
```

> The random() function returns a pseudo-random integer between
> -9223372036854775808 and +9223372036854775807.

```scala
def random: Expr[Long] = ...
```

> The randomblob(N) function return an N-byte blob containing pseudo-random bytes.
> If N is less than 1 then a 1-byte random blob is returned.
>
> Hint: applications can generate globally unique identifiers using this function
> together with hex() and/or lower() like this:
>
> hex(randomblob(16))
> lower(hex(randomblob(16)))

```scala
def randomBlob(n: Expr[Int]): Expr[geny.Bytes] = ...
```

> The char(X1,X2,...,XN) function returns a string composed of characters
> having the unicode code point values of the given integers

```scala
def char(values: Expr[Int]*): Expr[String] = ...
```

> The format(FORMAT,...) SQL function works like the sqlite3_mprintf() C-language
> function and the printf() function from the standard C library. The first
> argument is a format string that specifies how to construct the output string
> using values taken from subsequent arguments. If the FORMAT argument is missing
> or NULL then the result is NULL. The %n format is silently ignored and does not
> consume an argument. The %p format is an alias for %X. The %z format is
> interchangeable with %s. If there are too few arguments in the argument list,
> missing arguments are assumed to have a NULL value, which is translated into 0 or
> 0.0 for numeric formats or an empty string for %s. See the built-in printf()
> documentation for additional information.

```scala
def format(template: Expr[String], values: Expr[?]*): Expr[String] = ...
```

> The hex() function interprets its argument as a BLOB and returns a string which
> is the upper-case hexadecimal rendering of the content of that blob.
>
> If the argument X in "hex(X)" is an integer or floating point number, then
> "interprets its argument as a BLOB" means that the binary number is first converted
> into a UTF8 text representation, then that text is interpreted as a BLOB. Hence,
> "hex(12345678)" renders as "3132333435363738" not the binary representation of
> the integer value "0000000000BC614E".

```scala
def hex(value: Expr[?]): Expr[String] = ...
```

> The unhex(X,Y) function returns a BLOB value which is the decoding of the
> hexadecimal string X. If X contains any characters that are not hexadecimal
> digits and which are not in Y, then unhex(X,Y) returns NULL. If Y is omitted,
> it is understood to be an empty string and hence X must be a pure hexadecimal
> string. All hexadecimal digits in X must occur in pairs, with both digits of
> each pair beginning immediately adjacent to one another, or else unhex(X,Y)
> returns NULL. If either parameter X or Y is NULL, then unhex(X,Y) returns NULL.
> The X input may contain an arbitrary mix of upper and lower case hexadecimal
> digits. Hexadecimal digits in Y have no affect on the translation of X. Only
> characters in Y that are not hexadecimal digits are ignored in X.

```scala
def unhex(value: Expr[String]): Expr[geny.Bytes] = ...
```

> The unhex(X,Y) function returns a BLOB value which is the decoding of the
> hexadecimal string X. If X contains any characters that are not hexadecimal
> digits and which are not in Y, then unhex(X,Y) returns NULL. If Y is omitted,
> it is understood to be an empty string and hence X must be a pure hexadecimal
> string. All hexadecimal digits in X must occur in pairs, with both digits of
> each pair beginning immediately adjacent to one another, or else unhex(X,Y)
> returns NULL. If either parameter X or Y is NULL, then unhex(X,Y) returns NULL.
> The X input may contain an arbitrary mix of upper and lower case hexadecimal
> digits. Hexadecimal digits in Y have no affect on the translation of X. Only
> characters in Y that are not hexadecimal digits are ignored in X.

```scala
def zeroBlob(n: Expr[Int]): Expr[geny.Bytes] = ...
```

```scala
class AggExprOps[T](v: Aggregatable[Expr[T]]) extends scalasql.operations.ExprAggOps[T](v)
```

> TRUE if all values in a set are TRUE

```scala
def mkString(sep: Expr[String] = null)(implicit tm: TypeMapper[T]): Expr[String] = ...
```

```scala
class ExprStringOps[T](v: Expr[T]) extends ExprStringLikeOps(v) with operations.ExprStringOps[T]
```

```scala
class ExprStringLikeOps[T](protected val v: Expr[T])
```

```scala
def indexOf(x: Expr[T]): Expr[Int] = ...
```

```scala
def glob(x: Expr[T]): Expr[Boolean] = ...
```

```scala
class TableOps[V[_[_]]](t: Table[V]) extends scalasql.dialects.TableOps[V](t)
```

```scala
trait Select[Q, R] extends scalasql.query.Select[Q, R]
```

```scala
override def newCompoundSelect[Q, R](
        lhs: scalasql.query.SimpleSelect[Q, R],
        compoundOps: Seq[CompoundSelect.Op[Q, R]],
        orderBy: Seq[OrderBy],
        limit: Option[Int],
        offset: Option[Int]
    )(
        implicit qr: Queryable.Row[Q, R],
        dialect: scalasql.core.DialectTypeMappers
    ): scalasql.query.CompoundSelect[Q, R] = ...
```

```scala
override def newSimpleSelect[Q, R](
        expr: Q,
        exprPrefix: Option[Context => SqlStr],
        exprSuffix: Option[Context => SqlStr],
        preserveAll: Boolean,
        from: Seq[Context.From],
        joins: Seq[Join],
        where: Seq[Expr[?]],
        groupBy0: Option[GroupBy]
    )(
        implicit qr: Queryable.Row[Q, R],
        dialect: scalasql.core.DialectTypeMappers
    ): scalasql.query.SimpleSelect[Q, R] = ...
```

```scala
class SimpleSelect[Q, R](
      expr: Q,
      exprPrefix: Option[Context => SqlStr],
      exprSuffix: Option[Context => SqlStr],
      preserveAll: Boolean,
      from: Seq[Context.From],
      joins: Seq[Join],
      where: Seq[Expr[?]],
      groupBy0: Option[GroupBy]
  )(implicit qr: Queryable.Row[Q, R])
```

```scala
class CompoundSelect[Q, R](
      lhs: scalasql.query.SimpleSelect[Q, R],
      compoundOps: Seq[scalasql.query.CompoundSelect.Op[Q, R]],
      orderBy: Seq[OrderBy],
      limit: Option[Int],
      offset: Option[Int]
  )(implicit qr: Queryable.Row[Q, R])
```

```scala
class CompoundSelectRenderer[Q, R](
      query: scalasql.query.CompoundSelect[Q, R],
      prevContext: Context
  ) extends scalasql.query.CompoundSelect.Renderer(query, prevContext)
```

```scala
override lazy val limitOpt = ...
```

#### `dialects/TableOps.scala`

```scala
class TableOps[V[_[_]]](val t: Table[V])(implicit dialect: Dialect)
```

> Constructs a `SELECT` query

```scala
def select = ...
```

> Constructs a `UPDATE` query with the given [[filter]] to select the
> rows you want to delete

```scala
def update(filter: V[Column] => Expr[Boolean]): Update[V[Column], V[Sc]] = ...
```

> Constructs a `INSERT` query

```scala
def insert: Insert[V, V[Sc]] = ...
```

> Constructs a `DELETE` query with the given [[filter]] to select the
> rows you want to delete

```scala
def delete(filter: V[Column] => Expr[Boolean]): Delete[V[Column]] = ...
```

#### `package.scala`

```scala
package object scalasql
```

> Convenience alias for `geny.Bytes`

```scala
def Bytes(x: String): geny.Bytes = ...
```

> Convenience alias for `geny.Bytes`

```scala
def Bytes(x: Array[Byte]): geny.Bytes = ...
```

> Convenience alias for `geny.Bytes`

```scala
type Bytes = ...
```

```scala
type Sc[T] = ...
```

```scala
val Table = ...
```

```scala
type Table[V[_[_]]] = ...
```

```scala
val Column = ...
```

```scala
type Column[T] = ...
```

```scala
val DbClient = ...
```

```scala
type DbClient = ...
```

```scala
val DbApi = ...
```

```scala
type DbApi = ...
```

```scala
val Queryable = ...
```

```scala
type Queryable[Q, R] = ...
```

```scala
val Expr = ...
```

```scala
type Expr[T] = ...
```

```scala
type TypeMapper[T] = ...
```

```scala
val TypeMapper = ...
```

```scala
val Config = ...
```

```scala
type Config = ...
```

```scala
val SqlStr = ...
```

```scala
type SqlStr = ...
```

```scala
val MySqlDialect = ...
```

```scala
type MySqlDialect = ...
```

```scala
val PostgresDialect = ...
```

```scala
type PostgresDialect = ...
```

```scala
val H2Dialect = ...
```

```scala
type H2Dialect = ...
```

```scala
val SqliteDialect = ...
```

```scala
type SqliteDialect = ...
```

```scala
val MsSqlDialect = ...
```

```scala
type MsSqlDialect = ...
```

### `com.lihaoyi:scalasql-core_3:0.3.1`

Source: https://repo1.maven.org/maven2/com/lihaoyi/scalasql-core_3/0.3.1/scalasql-core_3-0.3.1-sources.jar

#### `Aggregatable.scala`

> Something that supports aggregate operations. Most commonly a [[Select]], but
> also could be a [[Aggregatable.Proxy]]

```scala
trait Aggregatable[Q] extends WithSqlExpr[Q]
```

```scala
def aggregateExpr[V: TypeMapper](f: Q => Context => SqlStr)(
      implicit qr: Queryable.Row[Expr[V], V]
  ): Expr[V]
```

```scala
object Aggregatable
```

> A reference that aggregations for usage within [[Select.aggregate]], to allow
> the caller to perform multiple aggregations within a single query.

```scala
class Proxy[Q](val expr: Q) extends Aggregatable[Q]
```

```scala
def aggregateExpr[V: TypeMapper](f: Q => Context => SqlStr)(
        implicit qr: Queryable.Row[Expr[V], V]
    ): Expr[V] = ...
```

#### `Config.scala`

> Things you to do to configure ScalaSql

```scala
trait Config
```

> Render a sequence of tokens to a column label; used primarily for
> making the generated queries more easily human readable.

```scala
def renderColumnLabel(tokens: Seq[String]): String = ...
```

> Configures the underlying JDBC connection's `setFetchSize`. Can be overriden
> on a per-query basis by passing `fetchSize = n` to `db.run`

```scala
def defaultFetchSize: Int = ...
```

> Configures the underlying JDBC connection's `setQueryTimeout`. Can be overriden
> on a per-query basis by passing `queryTimeoutSeconds = n` to `db.run`

```scala
def defaultQueryTimeoutSeconds: Int = ...
```

> Translates table and column names from Scala `object` names to SQL names.
>
> Use [[tableNameMapper]] and [[columnNameMapper]] if you want different
> translations for table and column names

```scala
def nameMapper(v: String): String = ...
```

> Translates table names from Scala `object` names to SQL names.

```scala
def tableNameMapper(v: String): String = ...
```

> Translates column names from Scala `case class` field names to SQL names.

```scala
def columnNameMapper(v: String): String = ...
```

> Override this to log the executed SQL queries

```scala
def logSql(sql: String, file: String, line: Int): Unit = ...
```

```scala
object Config
```

```scala
def isNormalCharacter(c: Char) = ...
```

```scala
def camelToSnake(s: String) = ...
```

#### `Context.scala`

> The contextual information necessary for rendering a ScalaSql query or expression
> into a SQL string

```scala
trait Context
```

> Any [[From]]/`FROM` clauses that are in scope, and the aliases those clauses are given

```scala
def fromNaming: Map[Context.From, String]
```

> Any [[Expr]]s/SQL-expressions that are present in [[fromNaming]], and what those
> expressions are named in SQL

```scala
def exprNaming: Map[Expr.Identity, SqlStr]
```

> Mark [[Expr]]s as a raw value for an INSERT or UPDATE context

```scala
def valueMarker: Boolean
```

> The ScalaSql configuration

```scala
def config: Config
```

```scala
def dialectConfig: DialectConfig
```

```scala
def withFromNaming(fromNaming: Map[Context.From, String]): Context
```

```scala
def withExprNaming(exprNaming: Map[Expr.Identity, SqlStr]): Context
```

```scala
def markAsValue: Context
```

```scala
object Context
```

```scala
trait From
```

> What alias to name this [[From]] for better readability

```scala
def fromRefPrefix(prevContext: Context): String
```

> A mapping of any aliased [[Expr]] that this [[From]] produces along
> with their rendered [[SqlStr]]s

```scala
def fromExprAliases(prevContext: Context): Seq[(Expr.Identity, SqlStr)]
```

> How this [[From]] can be rendered into a [[SqlStr]] for embedding into
> a larger query

```scala
def renderSql(
        name: SqlStr,
        prevContext: Context,
        liveExprs: LiveExprs
    ): SqlStr
```

```scala
case class Impl(
      fromNaming: Map[From, String],
      exprNaming: Map[Expr.Identity, SqlStr],
      valueMarker: Boolean,
      config: Config,
      dialectConfig: DialectConfig
  ) extends Context
```

```scala
def withFromNaming(fromNaming: Map[From, String]): Context = ...
```

```scala
def withExprNaming(exprNaming: Map[Expr.Identity, SqlStr]): Context = ...
```

```scala
def markAsValue: Context = ...
```

> Derives a new [[Context]] based on [[prevContext]] with additional [[prefixedFroms]]
> and [[unPrefixedFroms]] added to the [[Context.fromNaming]] and [[Context.exprNaming]]
> tables

```scala
def compute(prevContext: Context, prefixedFroms: Seq[From], unPrefixedFroms: Option[From]) = ...
```

#### `DbApi.scala`

> An interface to the SQL database allowing you to run queries.

```scala
trait DbApi extends AutoCloseable
```

> Converts the given query [[Q]] into a string. Useful for debugging and logging

```scala
def renderSql[Q, R](query: Q, castParams: Boolean = false)(implicit qr: Queryable[Q, R]): String
```

> Runs the given query [[Q]] and returns a value of type [[R]]

```scala
def run[Q, R](query: Q, fetchSize: Int = -1, queryTimeoutSeconds: Int = -1)(
      implicit qr: Queryable[Q, R],
      fileName: sourcecode.FileName,
      lineNum: sourcecode.Line
  ): R
```

> Runs the given [[SqlStr]] of the form `sql"..."` and returns a value of type [[R]]

```scala
def runSql[R](query: SqlStr, fetchSize: Int = -1, queryTimeoutSeconds: Int = -1)(
      implicit qr: Queryable.Row[?, R],
      fileName: sourcecode.FileName,
      lineNum: sourcecode.Line
  ): IndexedSeq[R]
```

> Runs the given query [[Q]] and returns a [[Generator]] of values of type [[R]].
> allow you to process the results in a streaming fashion without materializing
> the entire list of results in memory

```scala
def stream[Q, R](query: Q, fetchSize: Int = -1, queryTimeoutSeconds: Int = -1)(
      implicit qr: Queryable[Q, Seq[R]],
      fileName: sourcecode.FileName,
      lineNum: sourcecode.Line
  ): Generator[R]
```

> A combination of [[stream]] and [[runSql]], [[streamSql]] allows you to pass in an
> arbitrary [[SqlStr]] of the form `sql"..."` and  streams the results back to you

```scala
def streamSql[R](sql: SqlStr, fetchSize: Int = -1, queryTimeoutSeconds: Int = -1)(
      implicit qr: Queryable.Row[?, R],
      fileName: sourcecode.FileName,
      lineNum: sourcecode.Line
  ): Generator[R]
```

> Runs a `java.lang.String` (and any interpolated variables) and deserializes
> the result set into a `Seq` of the given type [[R]]

```scala
def runRaw[R](
      sql: String,
      variables: Seq[Any] = Nil,
      fetchSize: Int = -1,
      queryTimeoutSeconds: Int = -1
  )(
      implicit qr: Queryable.Row[?, R],
      fileName: sourcecode.FileName,
      lineNum: sourcecode.Line
  ): IndexedSeq[R]
```

> Runs a `java.lang.String` (and any interpolated variables) and deserializes
> the result set into a streaming `Generator` of the given type [[R]]

```scala
def streamRaw[R](
      sql: String,
      variables: Seq[Any] = Nil,
      fetchSize: Int = -1,
      queryTimeoutSeconds: Int = -1
  )(
      implicit qr: Queryable.Row[?, R],
      fileName: sourcecode.FileName,
      lineNum: sourcecode.Line
  ): Generator[R]
```

> Runs an [[SqlStr]] of the form `sql"..."` containing an `UPDATE` or `INSERT` query and returns the
> number of rows affected

```scala
def updateSql(sql: SqlStr, fetchSize: Int = -1, queryTimeoutSeconds: Int = -1)(
      implicit fileName: sourcecode.FileName,
      lineNum: sourcecode.Line
  ): Int
```

> Runs an `java.lang.String` (and any interpolated variables) containing an
> `UPDATE` or `INSERT` query and returns the number of rows affected

```scala
def updateRaw(
      sql: String,
      variables: Seq[Any] = Nil,
      fetchSize: Int = -1,
      queryTimeoutSeconds: Int = -1
  )(implicit fileName: sourcecode.FileName, lineNum: sourcecode.Line): Int
```

```scala
def updateGetGeneratedKeysSql[R](sql: SqlStr, fetchSize: Int = -1, queryTimeoutSeconds: Int = -1)(
      implicit qr: Queryable.Row[?, R],
      fileName: sourcecode.FileName,
      lineNum: sourcecode.Line
  ): IndexedSeq[R]
```

```scala
def updateGetGeneratedKeysRaw[R](
      sql: String,
      variables: Seq[Any] = Nil,
      fetchSize: Int = -1,
      queryTimeoutSeconds: Int = -1
  )(
      implicit qr: Queryable.Row[?, R],
      fileName: sourcecode.FileName,
      lineNum: sourcecode.Line
  ): IndexedSeq[R]
```

```scala
object DbApi
```

```scala
def unpackQueryable[R, Q](
      query: Q,
      qr: Queryable[Q, R],
      config: Config,
      dialectConfig: DialectConfig
  ) = ...
```

```scala
def renderSql[Q, R](query: Q, config: Config, dialectConfig: DialectConfig)(
      implicit qr: Queryable[Q, R]
  ): String = ...
```

> A listener that can be added to a [[DbApi.Txn]] to be notified of commit and rollback events.
>
> The default implementations of these methods do nothing, but you can override them to
> implement your own behavior.

```scala
trait TransactionListener
```

> Called when a new transaction is started.

```scala
def begin(): Unit = ...
```

> Called before the transaction is committed.
>
> If this method throws an exception, the transaction will be rolled back and the exception
> will be propagated.

```scala
def beforeCommit(): Unit = ...
```

> Called after the transaction is committed.
>
> If this method throws an exception, it will be propagated.

```scala
def afterCommit(): Unit = ...
```

> Called before the transaction is rolled back.
>
> If this method throws an exception, the transaction will be rolled back and the exception
> will be propagated to the caller of rollback().

```scala
def beforeRollback(): Unit = ...
```

> Called after the transaction is rolled back.
>
> If this method throws an exception, it will be propagated to the caller of rollback().

```scala
def afterRollback(): Unit = ...
```

> An interface to a SQL database *transaction*, allowing you to run queries,
> create savepoints, or roll back the transaction.

```scala
trait Txn extends DbApi
```

> Returns a [[UseBlock]] that creates a SQL Savepoint that is active within the given block; automatically
> releases the savepoint if the block completes successfully and rolls it back
> if the block terminates with an exception, and allows you to roll back the
> savepoint manually via the [[DbApi.Savepoint]] parameter passed to that block

```scala
def savepoint: UseBlock[DbApi.Savepoint]
```

> Rolls back any active Savepoints and then rolls back this Transaction

```scala
def rollback(): Unit
```

```scala
def addTransactionListener(listener: TransactionListener): Unit
```

> A SQL `SAVEPOINT`, with an ID, name, and the ability to roll back to when it was created

```scala
trait Savepoint
```

```scala
def savepointId: Int
```

```scala
def savepointName: String
```

```scala
def rollback(): Unit
```

```scala
class Impl(
      connection: java.sql.Connection,
      config: Config,
      dialect: DialectConfig,
      defaultListeners: Iterable[TransactionListener],
      autoCommit: Boolean
  ) extends DbApi.Txn
```

```scala
val listeners = ...
```

```scala
override def addTransactionListener(listener: TransactionListener): Unit = ...
```

```scala
def run[Q, R](query: Q, fetchSize: Int = -1, queryTimeoutSeconds: Int = -1)(
        implicit qr: Queryable[Q, R],
        fileName: sourcecode.FileName,
        lineNum: sourcecode.Line
    ): R = ...
```

```scala
def stream[Q, R](query: Q, fetchSize: Int = -1, queryTimeoutSeconds: Int = -1)(
        implicit qr: Queryable[Q, Seq[R]],
        fileName: sourcecode.FileName,
        lineNum: sourcecode.Line
    ): Generator[R] = ...
```

```scala
def runSql[R](
        sql: SqlStr,
        fetchSize: Int = -1,
        queryTimeoutSeconds: Int = -1
    )(
        implicit qr: Queryable.Row[?, R],
        fileName: sourcecode.FileName,
        lineNum: sourcecode.Line
    ): IndexedSeq[R] = ...
```

```scala
def streamSql[R](
        sql: SqlStr,
        fetchSize: Int = -1,
        queryTimeoutSeconds: Int = -1
    )(
        implicit qr: Queryable.Row[?, R],
        fileName: sourcecode.FileName,
        lineNum: sourcecode.Line
    ): Generator[R] = ...
```

```scala
def updateSql(sql: SqlStr, fetchSize: Int = -1, queryTimeoutSeconds: Int = -1)(
        implicit fileName: sourcecode.FileName,
        lineNum: sourcecode.Line
    ): Int = ...
```

```scala
def updateGetGeneratedKeysSql[R](
        sql: SqlStr,
        fetchSize: Int = -1,
        queryTimeoutSeconds: Int = -1
    )(
        implicit qr: Queryable.Row[?, R],
        fileName: sourcecode.FileName,
        lineNum: sourcecode.Line
    ): IndexedSeq[R] = ...
```

```scala
def runRaw[R](
        sql: String,
        variables: Seq[Any] = Nil,
        fetchSize: Int = -1,
        queryTimeoutSeconds: Int = -1
    )(
        implicit qr: Queryable.Row[?, R],
        fileName: sourcecode.FileName,
        lineNum: sourcecode.Line
    ): IndexedSeq[R] = ...
```

```scala
def streamRaw[R](
        sql: String,
        variables: Seq[Any] = Nil,
        fetchSize: Int = -1,
        queryTimeoutSeconds: Int = -1
    )(
        implicit qr: Queryable.Row[?, R],
        fileName: sourcecode.FileName,
        lineNum: sourcecode.Line
    ): Generator[R] = ...
```

```scala
def updateRaw(
        sql: String,
        variables: Seq[Any] = Nil,
        fetchSize: Int = -1,
        queryTimeoutSeconds: Int = -1
    )(implicit fileName: sourcecode.FileName, lineNum: sourcecode.Line): Int = ...
```

```scala
def updateGetGeneratedKeysRaw[R](
        sql: String,
        variables: Seq[Any] = Nil,
        fetchSize: Int = -1,
        queryTimeoutSeconds: Int = -1
    )(
        implicit qr: Queryable.Row[?, R],
        fileName: sourcecode.FileName,
        lineNum: sourcecode.Line
    ): IndexedSeq[R] = ...
```

```scala
def streamFlattened0[R](
        construct: Queryable.ResultSetIterator => R,
        flattened: SqlStr.Flattened,
        fetchSize: Int,
        queryTimeoutSeconds: Int,
        fileName: sourcecode.FileName,
        lineNum: sourcecode.Line
    ) = ...
```

```scala
def streamRaw0[R](
        construct: Queryable.ResultSetIterator => R,
        sql: String,
        variables: Seq[(PreparedStatement, Int) => Unit],
        fetchSize: Int,
        queryTimeoutSeconds: Int,
        fileName: sourcecode.FileName,
        lineNum: sourcecode.Line
    ) = ...
```

```scala
def runRawUpdate0(
        sql: String,
        variables: Seq[(PreparedStatement, Int) => Unit],
        fetchSize: Int,
        queryTimeoutSeconds: Int,
        fileName: sourcecode.FileName,
        lineNum: sourcecode.Line
    ): Int = ...
```

```scala
def runRawUpdateGetGeneratedKeys0[R](
        sql: String,
        variables: Seq[(PreparedStatement, Int) => Unit],
        fetchSize: Int,
        queryTimeoutSeconds: Int,
        fileName: sourcecode.FileName,
        lineNum: sourcecode.Line,
        qr: Queryable.Row[?, R]
    ): IndexedSeq[R] = ...
```

```scala
def configureRunCloseStatement[P <: Statement, T](
        statement: P,
        fetchSize: Int,
        queryTimeoutSeconds: Int,
        sql: String,
        fileName: sourcecode.FileName,
        lineNum: sourcecode.Line
    )(f: P => T): T = ...
```

```scala
def renderSql[Q, R](query: Q, castParams: Boolean = false)(
        implicit qr: Queryable[Q, R]
    ): String = ...
```

```scala
lazy val savepoint: UseBlock[DbApi.Savepoint] = ...
```

```scala
def rollback(): Unit = ...
```

> Attempts rollback, adding any exceptions as suppressed to the cause

```scala
def rollbackCause(cause: Throwable): Unit = ...
```

```scala
def close() = ...
```

```scala
class SavepointImpl(savepoint: java.sql.Savepoint, rollback0: () => Unit) extends Savepoint
```

```scala
def savepointId = ...
```

```scala
def savepointName = ...
```

```scala
def rollback() = ...
```

#### `DbClient.scala`

> A database client. Primarily allows you to access the database within a [[transaction]]
> block or via [[getAutoCommitClientConnection]]

```scala
trait DbClient
```

> Converts the given query [[Q]] into a string. Useful for debugging and logging

```scala
def renderSql[Q, R](query: Q, castParams: Boolean = false)(implicit qr: Queryable[Q, R]): String
```

> Returns a [[UseBlock]] for database transaction, automatically committing it
> if the block returns successfully and rolling it back if the blow fails with an uncaught
> exception. Within the block, you provides a [[DbApi.Txn]] you can use to run queries, create
> savepoints, or roll back the transaction.

```scala
def transaction: UseBlock[DbApi.Txn]
```

> Provides a [[DbApi]] that you can use to run queries in "auto-commit" mode, such
> that every query runs in its own transaction and is committed automatically on-completion.
>
> This can be useful for interactive testing, but requires that you manually manage the
> closing of the connection to avoid leaking connections (if using a connection pool like
> HikariCP), and should be avoided in most production environments in favor of
> `.transaction{...}` blocks.

```scala
def getAutoCommitClientConnection: DbApi
```

```scala
object DbClient
```

```scala
class Connection(
      connection: java.sql.Connection,
      config: Config = new Config {},
      /** Listeners that are added to all transactions created by this connection */
      listeners: Seq[DbApi.TransactionListener] = Seq.empty
  )(implicit dialect: DialectConfig)
```

```scala
def renderSql[Q, R](query: Q, castParams: Boolean = false)(
        implicit qr: Queryable[Q, R]
    ): String = ...
```

```scala
lazy val transaction: UseBlock[DbApi.Txn] = ...
```

```scala
def getAutoCommitClientConnection: DbApi = ...
```

```scala
class DataSource(
      dataSource: javax.sql.DataSource,
      config: Config = new Config {},
      /** Listeners that are added to all transactions created through the [[DataSource]] */
      listeners: Seq[DbApi.TransactionListener] = Seq.empty
  )(implicit dialect: DialectConfig)
```

> Returns a new [[DataSource]] with the given listener added

```scala
def withTransactionListener(listener: DbApi.TransactionListener): DbClient = ...
```

```scala
def renderSql[Q, R](query: Q, castParams: Boolean = false)(
        implicit qr: Queryable[Q, R]
    ): String = ...
```

```scala
lazy val withConnection: UseBlock[Connection] = ...
```

```scala
lazy val transaction: UseBlock[DbApi.Txn] = ...
```

```scala
def getAutoCommitClientConnection: DbApi = ...
```

#### `DialectConfig.scala`

```scala
trait DialectConfig
```

```scala
def castParams: Boolean
```

```scala
def escape(str: String): String
```

```scala
def supportSavepointRelease: Boolean
```

```scala
def withCastParams(params: Boolean) = ...
```

#### `DialectTypeMappers.scala`

> A default set of data type mappers that need to be present in any ScalaSql dialect

```scala
trait DialectTypeMappers extends DialectConfig
```

```scala
implicit val dialectSelf: DialectTypeMappers
```

```scala
implicit def StringType: TypeMapper[String]
```

```scala
implicit def ByteType: TypeMapper[Byte]
```

```scala
implicit def ShortType: TypeMapper[Short]
```

```scala
implicit def IntType: TypeMapper[Int]
```

```scala
implicit def LongType: TypeMapper[Long]
```

```scala
implicit def FloatType: TypeMapper[Float]
```

```scala
implicit def DoubleType: TypeMapper[Double]
```

```scala
implicit def BigDecimalType: TypeMapper[scala.math.BigDecimal]
```

```scala
implicit def BooleanType: TypeMapper[Boolean]
```

```scala
implicit def UuidType: TypeMapper[UUID]
```

```scala
implicit def BytesType: TypeMapper[geny.Bytes]
```

```scala
implicit def UtilDateType: TypeMapper[java.util.Date]
```

```scala
implicit def LocalDateType: TypeMapper[LocalDate]
```

```scala
implicit def LocalTimeType: TypeMapper[LocalTime]
```

```scala
implicit def LocalDateTimeType: TypeMapper[LocalDateTime]
```

```scala
implicit def ZonedDateTimeType: TypeMapper[ZonedDateTime]
```

```scala
implicit def InstantType: TypeMapper[Instant]
```

```scala
implicit def OffsetTimeType: TypeMapper[OffsetTime]
```

```scala
implicit def OffsetDateTimeType: TypeMapper[OffsetDateTime]
```

```scala
implicit def EnumType[T <: Enumeration#Value](implicit constructor: String => T): TypeMapper[T]
```

```scala
implicit def OptionType[T](implicit inner: TypeMapper[T]): TypeMapper[Option[T]]
```

#### `Expr.scala`

> A single "value" in your SQL query that can be mapped to and from
> a Scala value of a particular type [[T]]

```scala
trait Expr[T] extends SqlStr.Renderable
```

```scala
override def toString: String = ...
```

```scala
override def equals(other: Any): Boolean = ...
```

```scala
object Expr
```

```scala
def isLiteralTrue[T](e: Expr[T]): Boolean = ...
```

```scala
def toString[T](e: Expr[T]): String = ...
```

```scala
def identity[T](e: Expr[T]): Identity = ...
```

```scala
class Identity()
```

```scala
implicit def ExprQueryable[E[_] <: Expr[?], T](
      implicit mt: TypeMapper[T]
  ): Queryable.Row[E[T], T] = ...
```

```scala
class ExprQueryable[E[_] <: Expr[?], T](
      implicit tm: TypeMapper[T]
  ) extends Queryable.Row[E[T], T]
```

```scala
def walkLabels(): Seq[List[String]] = ...
```

```scala
def walkExprs(q: E[T]): Seq[Expr[?]] = ...
```

```scala
override def construct(args: Queryable.ResultSetIterator): T = ...
```

```scala
def deconstruct(r: T): E[T] = ...
```

```scala
def apply[T](f: Context => SqlStr): Expr[T] = ...
```

```scala
implicit def optionalize[T](e: Expr[T]): Expr[Option[T]] = ...
```

```scala
class Simple[T](f: Context => SqlStr) extends Expr[T]
```

```scala
def renderToSql0(implicit ctx: Context): SqlStr = ...
```

```scala
implicit def apply[T](
      x: T
  )(implicit conv: T => SqlStr.Interp): Expr[T] = ...
```

```scala
def apply0[T](
      x: T,
      exprIsLiteralTrue0: Boolean = false
  )(implicit conv: T => SqlStr.Interp): Expr[T] = ...
```

#### `ExprsToSql.scala`

```scala
object ExprsToSql
```

```scala
def apply(walked: Queryable.Walked, context: Context, prefix: SqlStr): SqlStr = ...
```

```scala
def selectColumnSql(walked: Queryable.Walked, ctx: Context): Seq[(String, SqlStr)] = ...
```

```scala
def selectColumnReferences(
      walked: Queryable.Walked,
      ctx: Context
  ): Seq[(Expr.Identity, SqlStr)] = ...
```

```scala
def booleanExprs(prefix: SqlStr, exprs: Seq[Expr[?]])(implicit ctx: Context) = ...
```

#### `FastAccumulator.scala`

```scala
class FastAccumulator[T: ClassTag](startSize: Int = 16)
```

```scala
val arr = ...
```

#### `Generated.scala`

```scala
trait QueryableRow
```

```scala
implicit def Tuple2Queryable[Q1, Q2, R1, R2](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2]
  ): Queryable.Row[(Q1, Q2), (R1, R2)] = ...
```

```scala
implicit def Tuple3Queryable[Q1, Q2, Q3, R1, R2, R3](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3]
  ): Queryable.Row[(Q1, Q2, Q3), (R1, R2, R3)] = ...
```

```scala
implicit def Tuple4Queryable[Q1, Q2, Q3, Q4, R1, R2, R3, R4](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4]
  ): Queryable.Row[(Q1, Q2, Q3, Q4), (R1, R2, R3, R4)] = ...
```

```scala
implicit def Tuple5Queryable[Q1, Q2, Q3, Q4, Q5, R1, R2, R3, R4, R5](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5), (R1, R2, R3, R4, R5)] = ...
```

```scala
implicit def Tuple6Queryable[Q1, Q2, Q3, Q4, Q5, Q6, R1, R2, R3, R4, R5, R6](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6), (R1, R2, R3, R4, R5, R6)] = ...
```

```scala
implicit def Tuple7Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, R1, R2, R3, R4, R5, R6, R7](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7), (R1, R2, R3, R4, R5, R6, R7)] = ...
```

```scala
implicit def Tuple8Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, R1, R2, R3, R4, R5, R6, R7, R8](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8), (R1, R2, R3, R4, R5, R6, R7, R8)] = ...
```

```scala
implicit def Tuple9Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, R1, R2, R3, R4, R5, R6, R7, R8, R9](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9), (R1, R2, R3, R4, R5, R6, R7, R8, R9)] = ...
```

```scala
implicit def Tuple10Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10)] = ...
```

```scala
implicit def Tuple11Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11)] = ...
```

```scala
implicit def Tuple12Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12)] = ...
```

```scala
implicit def Tuple13Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13)] = ...
```

```scala
implicit def Tuple14Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14)] = ...
```

```scala
implicit def Tuple15Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15)] = ...
```

```scala
implicit def Tuple16Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16)] = ...
```

```scala
implicit def Tuple17Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16], q17: Queryable.Row[Q17, R17]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17)] = ...
```

```scala
implicit def Tuple18Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16], q17: Queryable.Row[Q17, R17], q18: Queryable.Row[Q18, R18]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18)] = ...
```

```scala
implicit def Tuple19Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16], q17: Queryable.Row[Q17, R17], q18: Queryable.Row[Q18, R18], q19: Queryable.Row[Q19, R19]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19)] = ...
```

```scala
implicit def Tuple20Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16], q17: Queryable.Row[Q17, R17], q18: Queryable.Row[Q18, R18], q19: Queryable.Row[Q19, R19], q20: Queryable.Row[Q20, R20]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20)] = ...
```

```scala
implicit def Tuple21Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16], q17: Queryable.Row[Q17, R17], q18: Queryable.Row[Q18, R18], q19: Queryable.Row[Q19, R19], q20: Queryable.Row[Q20, R20], q21: Queryable.Row[Q21, R21]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21)] = ...
```

```scala
implicit def Tuple22Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16], q17: Queryable.Row[Q17, R17], q18: Queryable.Row[Q18, R18], q19: Queryable.Row[Q19, R19], q20: Queryable.Row[Q20, R20], q21: Queryable.Row[Q21, R21], q22: Queryable.Row[Q22, R22]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22)] = ...
```

#### `JoinNullable.scala`

> Represents a set of nullable columns that come from a `LEFT`/`RIGHT`/`OUTER` `JOIN`
> clause.

```scala
trait JoinNullable[Q]
```

```scala
def get: Q
```

```scala
def isEmpty[T](f: Q => Expr[T])(implicit qr: Queryable[Q, ?]): Expr[Boolean]
```

```scala
def nonEmpty[T](f: Q => Expr[T])(implicit qr: Queryable[Q, ?]): Expr[Boolean]
```

```scala
def map[V](f: Q => V): JoinNullable[V]
```

```scala
object JoinNullable
```

```scala
implicit def toExpr[T](n: JoinNullable[Expr[T]])(implicit mt: TypeMapper[T]): Expr[Option[T]] = ...
```

```scala
def apply[Q](t: Q): JoinNullable[Q] = ...
```

#### `LiveSqlExprs.scala`

> Models a set of live [[Expr]] expressions which need to be rendered;
> [[Expr]] expressions not in this set can be skipped during rendering
> to improve the conciseness of the rendered SQL string.
>
> - `None` is used to indicate this is a top-level context and we want
> all expressions to be rendered
>
> - `Some(set)` indicates that only the expressions present in the `set`
> need to be rendered, and the rest can be elided.
>
> Typically downstream parts of a SQL query (e.g. the outer `SELECT`) are
> rendered before the upstream parts (e.g. `FROM (SELECT ...)` subqueries),
> so the [[LiveExprs]] from the downstream parts can be used to decide
> which columns to skip when rendering the upstream parts. The outermost
> `SELECT` is rendered using [[LiveExprs.none]] since we cannot know what
> columns end up being used in the application code after the query has
> finished running, and thus have to preserve all of them

```scala
class LiveExprs(val values: Option[Set[Expr.Identity]])
```

```scala
def map(f: Set[Expr.Identity] => Set[Expr.Identity]) = ...
```

```scala
def isLive(e: Expr.Identity) = ...
```

```scala
object LiveExprs
```

```scala
def some(v: Set[Expr.Identity]) = ...
```

```scala
def none = ...
```

#### `Queryable.scala`

> Typeclass to indicate that we are able to evaluate a query of type [[Q]] to
> return a result of type [[R]]. Involves two operations: flattening a structured
> query to a flat list of expressions via [[walkLabelsAndExprs]], and reading a JSON-ish
> tree-shaped blob back into a return value via [[valueReader]]

```scala
trait Queryable[-Q, R]
```

> Whether this queryable value is executed using `java.sql.Statement.getGeneratedKeys`
> instead of `.executeQuery`.

```scala
def isGetGeneratedKeys(q: Q): Option[Queryable.Row[?, ?]]
```

> Whether this queryable value is executed using `java.sql.Statement.executeUpdate`
> instead of `.executeQuery`. Note that this needs to be known ahead of time, and
> cannot be discovered by just calling `.execute`, because some JDBC drivers do not
> properly handle updates in the `.execute` call

```scala
def isExecuteUpdate(q: Q): Boolean
```

> Returns a sequence of labels, each represented by a list of tokens, representing
> the expressions created by this queryable value. Used to add `AS foo_bar` labels
> to the generated queries, to aid in readability

```scala
def walkLabels(q: Q): Seq[List[String]]
```

> Returns a sequence of expressions created by this queryable value. Used to generate
> the column list `SELECT` clauses, both for nested and top level `SELECT`s

```scala
def walkExprs(q: Q): Seq[Expr[?]]
```

```scala
def walkLabelsAndExprs(q: Q): Queryable.Walked = ...
```

> Whether this query expects a single row to be returned, if so we can assert on
> the number of rows and raise an error if 0 rows or 2+ rows are present

```scala
def isSingleRow(q: Q): Boolean
```

> Converts the given queryable value into a [[SqlStr]], that can then be executed
> by the underlying SQL JDBC interface

```scala
def renderSql(q: Q, ctx: Context): SqlStr
```

> Construct a Scala return value from the [[Queryable.ResultSetIterator]] representing
> the return value of this queryable value

```scala
def construct(q: Q, args: Queryable.ResultSetIterator): R
```

```scala
object Queryable
```

```scala
type Walked = ...
```

```scala
class ResultSetIterator(r: ResultSet)
```

```scala
var index = ...
```

```scala
var nulls = ...
```

```scala
var nonNulls = ...
```

```scala
def consumeNulls(columnsCount: Int): Boolean = ...
```

```scala
def get[T](mt: TypeMapper[T]) = ...
```

> A [[Queryable]] that represents a part of a single database row. [[Queryable.Row]]s
> can be nested within other [[Queryable]]s, but [[Queryable]]s in general cannot. e.g.
>
> - `Select[Int]` is valid because `Select[Q]` takes a `Queryable.Row[Q]`, and
> there is a `Queryable.Row[Int]` available
>
> - `Select[Select[Int]]` is invalid because although there is a `Queryable[Select[Q]]`
> available, there is no `Queryable.Row[Select[Q]]`, as `Select[Q]` returns multiple rows

```scala
trait Row[Q, R] extends Queryable[Q, R]
```

```scala
def isGetGeneratedKeys(q: Q): Option[Queryable.Row[?, ?]] = ...
```

```scala
def isExecuteUpdate(q: Q): Boolean = ...
```

```scala
def isSingleRow(q: Q): Boolean = ...
```

```scala
def walkLabels(): Seq[List[String]]
```

```scala
def walkLabels(q: Q): Seq[List[String]] = ...
```

```scala
def renderSql(q: Q, ctx: Context): SqlStr = ...
```

```scala
def construct(q: Q, args: ResultSetIterator): R = ...
```

```scala
def construct(args: ResultSetIterator): R
```

> Takes the Scala-value of type [[R]] and converts it into a database-value of type [[Q]],
> potentially representing multiple columns. Used for inserting Scala values into `INSERT`
> or `VALUES` clauses

```scala
def deconstruct(r: R): Q
```

```scala
object Row extends scalasql.core.generated.QueryableRow
```

```scala
implicit def NullableQueryable[Q, R](
        implicit qr: Queryable.Row[Q, R]
    ): Queryable.Row[JoinNullable[Q], Option[R]] = ...
```

#### `SqlStr.scala`

> A SQL query with interpolated `?`s expressions and the associated
> interpolated values, of type [[Interp]]. Accumulates SQL snippets, parameters,
> and referenced expressions in a tree structure to minimize copying overhead,
> until [[SqlStr.flatten]] is called to convert it into a [[SqlStr.Flattened]]

```scala
class SqlStr(
    private val queryParts: Array[CharSequence],
    private val interps: Array[SqlStr.Interp],
    val isCompleteQuery: Boolean,
    private val referencedExprs: Array[Expr.Identity]
) extends SqlStr.Renderable
```

```scala
def +(other: SqlStr) = ...
```

```scala
def withCompleteQuery(v: Boolean) = ...
```

```scala
override def toString = ...
```

```scala
object SqlStr
```

> Represents a [[SqlStr]] that has been flattened out into a single set of
> parallel arrays, allowing you to render it or otherwise make use of its data.

```scala
class Flattened(
      val queryParts: Array[CharSequence],
      val interps0: Array[Interp],
      isCompleteQuery: Boolean,
      val referencedExprs: Array[Expr.Identity]
  ) extends SqlStr(queryParts, interps0, isCompleteQuery, referencedExprs)
```

```scala
def interpsIterator = ...
```

```scala
def renderSql(castParams: Boolean) = ...
```

> Helper method turn an `Option[T]` into a [[SqlStr]], returning
> the empty string if the `Option` is `None`

```scala
def opt[T](t: Option[T])(f: T => SqlStr) = ...
```

> Helper method turn an `Seq[T]` into a [[SqlStr]], returning
> the empty string if the `Seq` is empty

```scala
def optSeq[T](t: Seq[T])(f: Seq[T] => SqlStr) = ...
```

> Flattens out a [[SqlStr]] into a single flattened [[SqlStr.Flattened]] object,
> at which point you can use its `queryParts`, `params`, `referencedExprs`, etc.

```scala
def flatten(self: SqlStr): Flattened = ...
```

> Provides the sql"..." syntax for constructing [[SqlStr]]s

```scala
implicit class SqlStringSyntax(sc: StringContext)
```

```scala
def sql(args: Interp*) = ...
```

> Joins a `Seq` of [[SqlStr]]s into a single [[SqlStr]] using the given [[sep]] separator

```scala
def join(strs: IterableOnce[SqlStr], sep: SqlStr = empty): SqlStr = ...
```

```scala
lazy val empty = ...
```

```scala
lazy val commaSep = ...
```

> Converts a raw `String` into a [[SqlStr]]. Note that this must be used
> carefully to avoid SQL injection attacks.

```scala
def raw(s: String, referencedExprs: Array[Expr.Identity] = emptyIdentityArray) = ...
```

```scala
trait Renderable
```

```scala
object Renderable
```

```scala
def renderSql(x: Renderable)(implicit ctx: Context) = ...
```

> Something that can be interpolated into a [[SqlStr]].

```scala
sealed trait Interp
```

```scala
object Interp
```

```scala
implicit def renderableInterp(t: Renderable)(implicit ctx: Context): Interp = ...
```

```scala
implicit def sqlStrInterp(s: SqlStr): Interp = ...
```

```scala
case class SqlStrInterp(s: SqlStr) extends Interp
```

```scala
implicit def typeInterp[T: TypeMapper](value: T): Interp = ...
```

```scala
case class TypeInterp[T: TypeMapper](value: T) extends Interp
```

```scala
def mappedType: TypeMapper[T] = ...
```

#### `TypeMapper.scala`

> A mapping between a Scala type [[T]] and a JDBC type, defined by
> it's [[jdbcType]], [[castTypeString]], and [[get]] and [[put]] operations.
>
> Defaults are provided for most common Scala primitives, but you can also provide
> your own by defining an `implicit val foo: TypeMapper[T]`

```scala
trait TypeMapper[T]
```

> The JDBC type of this type.

```scala
def jdbcType: JDBCType
```

> What SQL string to use when you run `cast[T]` to a specific type

```scala
def castTypeString: String = ...
```

> How to extract a value of type [[T]] from a `ResultSet`

```scala
def get(r: ResultSet, idx: Int): T
```

> How to insert a value of type [[T]] into a `PreparedStatement`

```scala
def put(r: PreparedStatement, idx: Int, v: T): Unit
```

> Create a new `TypeMapper[V]` based on this `TypeMapper[T]` given the
> two conversion functions `f: V => T`, `g: T => V`

```scala
def bimap[V](f: V => T, g: T => V): TypeMapper[V] = ...
```

```scala
object TypeMapper
```

```scala
def apply[T](implicit t: TypeMapper[T]): TypeMapper[T] = ...
```

#### `UseBlock.scala`

> A block abstraction that wraps resource usage with proper acquiring and close/release.
> Exposes lifecycle operations separately, which is useful for integration with FP effect libraries.
> Should not be implemented outside of library code, so sealed.
>
> @tparam A The resource type provided during the `use` phase

```scala
sealed trait UseBlock[+A]
```

> Acquires the resource. Called once at the start of the block.
> @return The acquired resource and release function.

```scala
def allocate(): (A, Option[Throwable] => Unit)
```

> Combines acquire, use, and release into a single operation.
> Makes it friendly to traditional block-style API.

```scala
final def apply[T](use: A => T): T = ...
```

#### `WithSqlExpr.scala`

```scala
trait WithSqlExpr[Q]
```

```scala
object WithSqlExpr
```

```scala
def get[Q](v: WithSqlExpr[Q]) = ...
```

#### `package.scala`

```scala
package object core
```

```scala
type Sc[T] = ...
```

### `com.lihaoyi:scalasql-query_3:0.3.1`

Source: https://repo1.maven.org/maven2/com/lihaoyi/scalasql-query_3/0.3.1/scalasql-query_3-0.3.1-sources.jar

#### `Aggregate.scala`

```scala
class Aggregate[Q, R](
    toSqlStr0: Context => SqlStr,
    construct0: Queryable.ResultSetIterator => R,
    protected val expr: Q,
    protected val qr: Queryable[Q, R]
) extends Query.DelegateQueryable[Q, R]
```

#### `Column.scala`

> A variant of [[Expr]] representing a raw table column; allows assignment in updates
> and inserts

```scala
class Column[T](tableRef: TableRef, val name: String)(implicit val mappedType: TypeMapper[T])
```

```scala
def : = ...
```

```scala
def renderToSql0(implicit ctx: Context) = ...
```

```scala
object Column
```

```scala
case class Assignment[T](column: Column[T], value: Expr[T])
```

#### `CompoundSelect.scala`

> A SQL `SELECT` query, with
> `ORDER BY`, `LIMIT`, `OFFSET`, or `UNION` clauses

```scala
class CompoundSelect[Q, R](
    val lhs: SimpleSelect[Q, R],
    val compoundOps: Seq[CompoundSelect.Op[Q, R]],
    val orderBy: Seq[OrderBy],
    val limit: Option[Int],
    val offset: Option[Int]
)(implicit val qr: Queryable.Row[Q, R], val dialect: DialectTypeMappers)
```

```scala
override def map[Q2, R2](f: Q => Q2)(implicit qr2: Queryable.Row[Q2, R2]): Select[Q2, R2] = ...
```

```scala
override def filter(f: Q => Expr[Boolean]): Select[Q, R] = ...
```

```scala
override def sortBy(f: Q => Expr[?]) = ...
```

```scala
override def asc: Select[Q, R] = ...
```

```scala
override def desc: Select[Q, R] = ...
```

```scala
override def nullsFirst: Select[Q, R] = ...
```

```scala
override def nullsLast: Select[Q, R] = ...
```

```scala
override def compound0(op: String, other: Select[Q, R]) = ...
```

```scala
override def drop(n: Int): Select[Q, R] = ...
```

```scala
override def take(n: Int): Select[Q, R] = ...
```

```scala
object CompoundSelect
```

```scala
case class Op[Q, R](op: String, rhs: SimpleSelect[Q, R])
```

```scala
class Renderer[Q, R](query: CompoundSelect[Q, R], prevContext: Context)
```

```scala
lazy val renderer = ...
```

```scala
lazy val lhsExprAliases = ...
```

```scala
lazy val context = ...
```

```scala
lazy val sortOpt = ...
```

```scala
lazy val limitOpt = ...
```

```scala
lazy val offsetOpt = ...
```

```scala
lazy val newReferencedExpressions = ...
```

```scala
lazy val preserveAll = ...
```

```scala
def render(liveExprs: LiveExprs) = ...
```

```scala
def orderToSqlStr(newCtx: Context) = ...
```

```scala
def orderToSqlStr(orderBys: Seq[OrderBy], newCtx: Context, gap: Boolean = false) = ...
```

#### `Delete.scala`

> A SQL `DELETE` query

```scala
trait Delete[Q] extends Query.ExecuteUpdate[Int] with Returning.Base[Q]
```

```scala
object Delete
```

```scala
class Impl[Q](val expr: Q, filter: Expr[Boolean], val table: TableRef)(
      implicit dialect: DialectTypeMappers
  ) extends Delete[Q]
```

```scala
class Renderer(table: TableRef, expr: Expr[Boolean], prevContext: Context)
```

```scala
implicit val implicitCtx: Context = ...
```

```scala
lazy val tableNameStr = ...
```

```scala
lazy val filtersOpt = ...
```

```scala
def render() = ...
```

#### `FlatJoin.scala`

```scala
object FlatJoin
```

```scala
trait Rhs[Q2, R2]
```

```scala
class MapResult[Q, Q2, R, R2](
      val prefix: String,
      val from: Context.From,
      val on: Option[Expr[Boolean]],
      val qr: Queryable.Row[Q2, R2],
      val f: Q2,
      val where: Seq[Expr[Boolean]]
  ) extends Rhs[Q2, R2]
```

```scala
class FlatMapResult[Q, Q2, R, R2](
      val prefix: String,
      val from: Context.From,
      val on: Option[Expr[Boolean]],
      val qr: Queryable.Row[Q2, R2],
      val f: Rhs[Q2, R2],
      val where: Seq[Expr[Boolean]]
  ) extends Rhs[Q2, R2]
```

```scala
class Mapper[Q, Q2, R, R2](
      prefix: String,
      from: Context.From,
      expr: Q,
      on: Option[Expr[Boolean]],
      where: Seq[Expr[Boolean]]
  )
```

```scala
def map(f: Q => Q2)(implicit qr: Queryable.Row[Q2, R2]): MapResult[Q, Q2, R, R2] = ...
```

```scala
def flatMap(
        f: Q => Rhs[Q2, R2]
    )(implicit qr: Queryable.Row[Q2, R2]): FlatMapResult[Q, Q2, R, R2] = ...
```

```scala
def filter(x: Q => Expr[Boolean]): Mapper[Q, Q2, R, R2] = ...
```

```scala
def withFilter(x: Q => Expr[Boolean]): Mapper[Q, Q2, R, R2] = ...
```

```scala
class NullableMapper[Q, Q2, R, R2](
      prefix: String,
      from: Context.From,
      expr: JoinNullable[Q],
      on: Option[Expr[Boolean]],
      where: Seq[Expr[Boolean]]
  )
```

```scala
def lateral = ...
```

```scala
def map(
        f: JoinNullable[Q] => Q2
    )(implicit qr: Queryable.Row[Q2, R2]): MapResult[Q, Q2, R, R2] = ...
```

```scala
def flatMap(
        f: JoinNullable[Q] => Rhs[Q2, R2]
    )(implicit qr: Queryable.Row[Q2, R2]): FlatMapResult[Q, Q2, R, R2] = ...
```

```scala
def filter(x: JoinNullable[Q] => Expr[Boolean]): NullableMapper[Q, Q2, R, R2] = ...
```

```scala
def withFilter(x: JoinNullable[Q] => Expr[Boolean]): NullableMapper[Q, Q2, R, R2] = ...
```

#### `From.scala`

> Models a SQL `FROM` clause

```scala
class TableRef(val value: Table.Base) extends From
```

```scala
override def toString = ...
```

```scala
def fromRefPrefix(prevContext: Context) = ...
```

```scala
def fromExprAliases(prevContext: Context): Seq[(Expr.Identity, SqlStr)] = ...
```

```scala
def renderSql(name: SqlStr, prevContext: Context, liveExprs: LiveExprs) = ...
```

> Models a subquery: a `SELECT`, `VALUES`, nested `WITH`, etc.

```scala
class SubqueryRef(val value: SubqueryRef.Wrapped) extends From
```

```scala
def fromRefPrefix(prevContext: Context): String = ...
```

```scala
def fromExprAliases(prevContext: Context) = ...
```

```scala
def renderSql(name: SqlStr, prevContext: Context, liveExprs: LiveExprs) = ...
```

```scala
object SubqueryRef
```

```scala
trait Wrapped
```

```scala
object Wrapped
```

```scala
def exprAliases(s: Wrapped, prevContext: Context) = ...
```

```scala
def renderer(s: Wrapped, prevContext: Context) = ...
```

```scala
trait Renderer
```

```scala
def render(liveExprs: LiveExprs): SqlStr
```

```scala
class WithCteRef(walked: Queryable.Walked) extends From
```

```scala
def fromRefPrefix(prevContext: Context) = ...
```

```scala
def fromExprAliases(prevContext: Context) = ...
```

```scala
def renderSql(name: SqlStr, prevContext: Context, liveExprs: LiveExprs) = ...
```

#### `Generated.scala`

```scala
trait Insert[V[_[_]], R]
```

```scala
def batched[T1, T2](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2])(
      items: (Expr[T1], Expr[T2])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3])(
      items: (Expr[T1], Expr[T2], Expr[T3])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16], f17: V[Column] => Column[T17])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16], Expr[T17])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16], f17: V[Column] => Column[T17], f18: V[Column] => Column[T18])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16], Expr[T17], Expr[T18])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16], f17: V[Column] => Column[T17], f18: V[Column] => Column[T18], f19: V[Column] => Column[T19])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16], Expr[T17], Expr[T18], Expr[T19])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16], f17: V[Column] => Column[T17], f18: V[Column] => Column[T18], f19: V[Column] => Column[T19], f20: V[Column] => Column[T20])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16], Expr[T17], Expr[T18], Expr[T19], Expr[T20])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20, T21](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16], f17: V[Column] => Column[T17], f18: V[Column] => Column[T18], f19: V[Column] => Column[T19], f20: V[Column] => Column[T20], f21: V[Column] => Column[T21])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16], Expr[T17], Expr[T18], Expr[T19], Expr[T20], Expr[T21])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20, T21, T22](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16], f17: V[Column] => Column[T17], f18: V[Column] => Column[T18], f19: V[Column] => Column[T19], f20: V[Column] => Column[T20], f21: V[Column] => Column[T21], f22: V[Column] => Column[T22])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16], Expr[T17], Expr[T18], Expr[T19], Expr[T20], Expr[T21], Expr[T22])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
trait InsertImpl[V[_[_]], R] extends Insert[V, R]
```

```scala
def newInsertValues[R](
        insert: scalasql.query.Insert[V, R],
        columns: Seq[Column[?]],
        valuesLists: Seq[Seq[Expr[?]]]
    )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R]
```

```scala
def batched[T1, T2](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2])(
      items: (Expr[T1], Expr[T2])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3])(
      items: (Expr[T1], Expr[T2], Expr[T3])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16], f17: V[Column] => Column[T17])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16], Expr[T17])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16], f17: V[Column] => Column[T17], f18: V[Column] => Column[T18])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16], Expr[T17], Expr[T18])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16], f17: V[Column] => Column[T17], f18: V[Column] => Column[T18], f19: V[Column] => Column[T19])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16], Expr[T17], Expr[T18], Expr[T19])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16], f17: V[Column] => Column[T17], f18: V[Column] => Column[T18], f19: V[Column] => Column[T19], f20: V[Column] => Column[T20])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16], Expr[T17], Expr[T18], Expr[T19], Expr[T20])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20, T21](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16], f17: V[Column] => Column[T17], f18: V[Column] => Column[T18], f19: V[Column] => Column[T19], f20: V[Column] => Column[T20], f21: V[Column] => Column[T21])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16], Expr[T17], Expr[T18], Expr[T19], Expr[T20], Expr[T21])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
def batched[T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16, T17, T18, T19, T20, T21, T22](f1: V[Column] => Column[T1], f2: V[Column] => Column[T2], f3: V[Column] => Column[T3], f4: V[Column] => Column[T4], f5: V[Column] => Column[T5], f6: V[Column] => Column[T6], f7: V[Column] => Column[T7], f8: V[Column] => Column[T8], f9: V[Column] => Column[T9], f10: V[Column] => Column[T10], f11: V[Column] => Column[T11], f12: V[Column] => Column[T12], f13: V[Column] => Column[T13], f14: V[Column] => Column[T14], f15: V[Column] => Column[T15], f16: V[Column] => Column[T16], f17: V[Column] => Column[T17], f18: V[Column] => Column[T18], f19: V[Column] => Column[T19], f20: V[Column] => Column[T20], f21: V[Column] => Column[T21], f22: V[Column] => Column[T22])(
      items: (Expr[T1], Expr[T2], Expr[T3], Expr[T4], Expr[T5], Expr[T6], Expr[T7], Expr[T8], Expr[T9], Expr[T10], Expr[T11], Expr[T12], Expr[T13], Expr[T14], Expr[T15], Expr[T16], Expr[T17], Expr[T18], Expr[T19], Expr[T20], Expr[T21], Expr[T22])*
  )(implicit qr: Queryable[V[Column], R]): scalasql.query.InsertColumns[V, R] = ...
```

```scala
trait QueryableRow
```

```scala
implicit def Tuple2Queryable[Q1, Q2, R1, R2](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2]
  ): Queryable.Row[(Q1, Q2), (R1, R2)] = ...
```

```scala
implicit def Tuple3Queryable[Q1, Q2, Q3, R1, R2, R3](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3]
  ): Queryable.Row[(Q1, Q2, Q3), (R1, R2, R3)] = ...
```

```scala
implicit def Tuple4Queryable[Q1, Q2, Q3, Q4, R1, R2, R3, R4](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4]
  ): Queryable.Row[(Q1, Q2, Q3, Q4), (R1, R2, R3, R4)] = ...
```

```scala
implicit def Tuple5Queryable[Q1, Q2, Q3, Q4, Q5, R1, R2, R3, R4, R5](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5), (R1, R2, R3, R4, R5)] = ...
```

```scala
implicit def Tuple6Queryable[Q1, Q2, Q3, Q4, Q5, Q6, R1, R2, R3, R4, R5, R6](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6), (R1, R2, R3, R4, R5, R6)] = ...
```

```scala
implicit def Tuple7Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, R1, R2, R3, R4, R5, R6, R7](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7), (R1, R2, R3, R4, R5, R6, R7)] = ...
```

```scala
implicit def Tuple8Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, R1, R2, R3, R4, R5, R6, R7, R8](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8), (R1, R2, R3, R4, R5, R6, R7, R8)] = ...
```

```scala
implicit def Tuple9Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, R1, R2, R3, R4, R5, R6, R7, R8, R9](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9), (R1, R2, R3, R4, R5, R6, R7, R8, R9)] = ...
```

```scala
implicit def Tuple10Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10)] = ...
```

```scala
implicit def Tuple11Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11)] = ...
```

```scala
implicit def Tuple12Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12)] = ...
```

```scala
implicit def Tuple13Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13)] = ...
```

```scala
implicit def Tuple14Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14)] = ...
```

```scala
implicit def Tuple15Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15)] = ...
```

```scala
implicit def Tuple16Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16)] = ...
```

```scala
implicit def Tuple17Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16], q17: Queryable.Row[Q17, R17]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17)] = ...
```

```scala
implicit def Tuple18Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16], q17: Queryable.Row[Q17, R17], q18: Queryable.Row[Q18, R18]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18)] = ...
```

```scala
implicit def Tuple19Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16], q17: Queryable.Row[Q17, R17], q18: Queryable.Row[Q18, R18], q19: Queryable.Row[Q19, R19]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19)] = ...
```

```scala
implicit def Tuple20Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16], q17: Queryable.Row[Q17, R17], q18: Queryable.Row[Q18, R18], q19: Queryable.Row[Q19, R19], q20: Queryable.Row[Q20, R20]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20)] = ...
```

```scala
implicit def Tuple21Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16], q17: Queryable.Row[Q17, R17], q18: Queryable.Row[Q18, R18], q19: Queryable.Row[Q19, R19], q20: Queryable.Row[Q20, R20], q21: Queryable.Row[Q21, R21]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21)] = ...
```

```scala
implicit def Tuple22Queryable[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22](
      implicit
      q1: Queryable.Row[Q1, R1], q2: Queryable.Row[Q2, R2], q3: Queryable.Row[Q3, R3], q4: Queryable.Row[Q4, R4], q5: Queryable.Row[Q5, R5], q6: Queryable.Row[Q6, R6], q7: Queryable.Row[Q7, R7], q8: Queryable.Row[Q8, R8], q9: Queryable.Row[Q9, R9], q10: Queryable.Row[Q10, R10], q11: Queryable.Row[Q11, R11], q12: Queryable.Row[Q12, R12], q13: Queryable.Row[Q13, R13], q14: Queryable.Row[Q14, R14], q15: Queryable.Row[Q15, R15], q16: Queryable.Row[Q16, R16], q17: Queryable.Row[Q17, R17], q18: Queryable.Row[Q18, R18], q19: Queryable.Row[Q19, R19], q20: Queryable.Row[Q20, R20], q21: Queryable.Row[Q21, R21], q22: Queryable.Row[Q22, R22]
  ): Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22)] = ...
```

```scala
trait JoinAppend extends scalasql.query.JoinAppendLowPriority
```

```scala
implicit def append2[Q1, Q2, QA, R1, R2, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, QA), (R1, R2, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2), QA, (Q1, Q2, QA), (R1, R2, RA)] = ...
```

```scala
implicit def append3[Q1, Q2, Q3, QA, R1, R2, R3, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, QA), (R1, R2, R3, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3), QA, (Q1, Q2, Q3, QA), (R1, R2, R3, RA)] = ...
```

```scala
implicit def append4[Q1, Q2, Q3, Q4, QA, R1, R2, R3, R4, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, QA), (R1, R2, R3, R4, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4), QA, (Q1, Q2, Q3, Q4, QA), (R1, R2, R3, R4, RA)] = ...
```

```scala
implicit def append5[Q1, Q2, Q3, Q4, Q5, QA, R1, R2, R3, R4, R5, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, QA), (R1, R2, R3, R4, R5, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5), QA, (Q1, Q2, Q3, Q4, Q5, QA), (R1, R2, R3, R4, R5, RA)] = ...
```

```scala
implicit def append6[Q1, Q2, Q3, Q4, Q5, Q6, QA, R1, R2, R3, R4, R5, R6, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, QA), (R1, R2, R3, R4, R5, R6, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6), QA, (Q1, Q2, Q3, Q4, Q5, Q6, QA), (R1, R2, R3, R4, R5, R6, RA)] = ...
```

```scala
implicit def append7[Q1, Q2, Q3, Q4, Q5, Q6, Q7, QA, R1, R2, R3, R4, R5, R6, R7, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, QA), (R1, R2, R3, R4, R5, R6, R7, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, QA), (R1, R2, R3, R4, R5, R6, R7, RA)] = ...
```

```scala
implicit def append8[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, QA, R1, R2, R3, R4, R5, R6, R7, R8, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, QA), (R1, R2, R3, R4, R5, R6, R7, R8, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, QA), (R1, R2, R3, R4, R5, R6, R7, R8, RA)] = ...
```

```scala
implicit def append9[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, QA, R1, R2, R3, R4, R5, R6, R7, R8, R9, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, RA)] = ...
```

```scala
implicit def append10[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, QA, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, RA)] = ...
```

```scala
implicit def append11[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, QA, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, RA)] = ...
```

```scala
implicit def append12[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, QA, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, RA)] = ...
```

```scala
implicit def append13[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, QA, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, RA)] = ...
```

```scala
implicit def append14[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, QA, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, RA)] = ...
```

```scala
implicit def append15[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, QA, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, RA)] = ...
```

```scala
implicit def append16[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, QA, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, RA)] = ...
```

```scala
implicit def append17[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, QA, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, RA)] = ...
```

```scala
implicit def append18[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, QA, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, RA)] = ...
```

```scala
implicit def append19[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, QA, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, RA)] = ...
```

```scala
implicit def append20[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, QA, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, RA)] = ...
```

```scala
implicit def append21[Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, QA, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, RA](
        implicit qr0: Queryable.Row[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, RA)],
        @annotation.nowarn("msg=never used") qr20: Queryable.Row[QA, RA]): scalasql.query.JoinAppend[(Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21), QA, (Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, QA), (R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, RA)] = ...
```

#### `GetGeneratedKeys.scala`

> Represents an [[Insert]] query that you want to call `JdbcStatement.getGeneratedKeys`
> on to retrieve any auto-generated primary key values from the results

```scala
trait GetGeneratedKeys[Q, R] extends Query[Seq[R]]
```

```scala
def single: Query.Single[R] = ...
```

```scala
object GetGeneratedKeys
```

```scala
class Impl[Q, R](base: Returning.InsertBase[Q])(implicit qr: Queryable.Row[?, R])
```

```scala
def expr = ...
```

#### `Insert.scala`

> A SQL `INSERT` query

```scala
trait Insert[V[_[_]], R] extends WithSqlExpr[V[Column]] with scalasql.generated.Insert[V, R]
```

```scala
def table: TableRef
```

```scala
def qr: Queryable[V[Column], R]
```

```scala
def select[C, R2](columns: V[Expr] => C, select: Select[C, R2]): InsertSelect[V, C, R, R2]
```

```scala
def columns(f: (V[Column] => Column.Assignment[?])*): InsertColumns[V, R]
```

```scala
def values(f: R*): InsertValues[V, R]
```

```scala
def batched[T1](f1: V[Column] => Column[T1])(items: Expr[T1]*): InsertColumns[V, R]
```

```scala
object Insert
```

```scala
class Impl[V[_[_]], R](val expr: V[Column], val table: TableRef)(
      implicit val qr: Queryable.Row[V[Column], R],
      dialect: DialectTypeMappers
  ) extends Insert[V, R]
      with scalasql.generated.InsertImpl[V, R]
```

```scala
def newInsertSelect[C, R, R2](
        insert: Insert[V, R],
        columns: C,
        select: Select[C, R2]
    ): InsertSelect[V, C, R, R2] = ...
```

```scala
def newInsertValues[R](
        insert: Insert[V, R],
        columns: Seq[Column[?]],
        valuesLists: Seq[Seq[Expr[?]]]
    )(implicit qr: Queryable[V[Column], R]): InsertColumns[V, R] = ...
```

```scala
def select[C, R2](columns: V[Expr] => C, select: Select[C, R2]): InsertSelect[V, C, R, R2] = ...
```

```scala
def columns(f: (V[Column] => Column.Assignment[?])*): InsertColumns[V, R] = ...
```

```scala
def batched[T1](f1: V[Column] => Column[T1])(items: Expr[T1]*): InsertColumns[V, R] = ...
```

```scala
override def values(values: R*): InsertValues[V, R] = ...
```

#### `InsertColumns.scala`

> A SQL `INSERT VALUES` query

```scala
trait InsertColumns[V[_[_]], R]
    extends Returning.InsertBase[V[Column]]
    with Query.ExecuteUpdate[Int]
```

```scala
def columns: Seq[Column[?]]
```

```scala
def valuesLists: Seq[Seq[Expr[?]]]
```

```scala
object InsertColumns
```

```scala
class Impl[V[_[_]], R](
      insert: Insert[V, R],
      val columns: Seq[Column[?]],
      val valuesLists: Seq[Seq[Expr[?]]]
  )(implicit val qr: Queryable[V[Column], R], dialect: DialectTypeMappers)
```

```scala
def table = ...
```

```scala
class Renderer(
      columns0: Seq[Column[?]],
      prevContext: Context,
      valuesLists: Seq[Seq[Expr[?]]],
      tableName: String
  )
```

```scala
implicit lazy val ctx: Context = ...
```

```scala
lazy val columns = ...
```

```scala
lazy val values = ...
```

```scala
def render() = ...
```

#### `InsertSelect.scala`

> A SQL `INSERT SELECT` query

```scala
trait InsertSelect[V[_[_]], C, R, R2]
    extends Returning.InsertBase[V[Column]]
    with Query.ExecuteUpdate[Int]
```

```scala
object InsertSelect
```

```scala
class Impl[V[_[_]], C, R, R2](insert: Insert[V, R], columns: C, select: Select[C, R2])(
      implicit dialect: DialectTypeMappers
  ) extends InsertSelect[V, C, R, R2]
```

```scala
def table = ...
```

```scala
class Renderer(
      select: Select[?, ?],
      exprs: Seq[Expr[?]],
      prevContext: Context,
      tableName: String
  )
```

```scala
implicit lazy val ctx: Context = ...
```

```scala
lazy val columns = ...
```

```scala
lazy val selectSql = ...
```

```scala
lazy val tableNameStr = ...
```

```scala
def render() = ...
```

#### `InsertValues.scala`

```scala
trait InsertValues[V[_[_]], R]
    extends Returning.InsertBase[V[Column]]
    with Query.ExecuteUpdate[Int]
```

```scala
def skipColumns(x: (V[Column] => Column[?])*): InsertValues[V, R]
```

```scala
object InsertValues
```

```scala
class Impl[V[_[_]], R](
      insert: Insert[V, R],
      values: Seq[R],
      dialect: DialectTypeMappers,
      qr: Queryable.Row[V[Column], R],
      skippedColumns: Seq[Column[?]]
  ) extends InsertValues[V, R]
```

```scala
def table = ...
```

```scala
override def skipColumns(x: (V[Column] => Column[?])*): InsertValues[V, R] = ...
```

```scala
class Renderer[Q, R](
      tableName: String,
      columnsList0: Seq[String],
      valuesList: Seq[R],
      qr: Queryable.Row[Q, R],
      skippedColumns: Seq[Column[?]]
  )(implicit ctx: Context)
```

```scala
lazy val skippedColumnsNames = ...
```

```scala
lazy val (liveCols, liveIndices) = ...
```

```scala
lazy val columns = ...
```

```scala
lazy val liveIndicesSet = ...
```

```scala
val valuesSqls = ...
```

```scala
lazy val values = ...
```

```scala
def render() = ...
```

#### `JoinAppend.scala`

> Typeclass to allow `.join` to append tuples, such that `Query[(A, B)].join(Query[C])`
> returns a flat `Query[(A, B, C)]` rather than a nested `Query[((A, B), B)]`. Can't
> eliminate nesting in all cases, but eliminates nesting often enough to be useful

```scala
trait JoinAppend[Q, Q2, QF, RF]
```

```scala
def appendTuple(t: Q, v: Q2): QF
```

```scala
def qr: Queryable.Row[QF, RF]
```

```scala
object JoinAppend extends scalasql.generated.JoinAppend
```

```scala
trait JoinAppendLowPriority
```

```scala
implicit def default[Q, R, Q2, R2](
      implicit qr0: Queryable.Row[Q, R],
      qr20: Queryable.Row[Q2, R2]
  ): JoinAppend[Q, Q2, (Q, Q2), (R, R2)] = ...
```

#### `JoinOps.scala`

```scala
trait JoinOps[C[_, _], Q, R] extends WithSqlExpr[Q]
```

> Performs a `JOIN`/`INNER JOIN` on the given [[other]], typically a [[Table]] or [[Select]].

```scala
def join[Q2, R2, QF, RF](other: Joinable[Q2, R2])(on: (Q, Q2) => Expr[Boolean])(
      implicit ja: JoinAppend[Q, Q2, QF, RF]
  ): C[QF, RF] = ...
```

> Performs a `CROSS JOIN`, which is an `INNER JOIN` but without the `ON` clause

```scala
def crossJoin[Q2, R2, QF, RF](other: Joinable[Q2, R2])(
      implicit ja: JoinAppend[Q, Q2, QF, RF]
  ): C[QF, RF] = ...
```

```scala
object JoinOps
```

```scala
def join0[C[_, _], Q, R, Q2, R2, QF, RF](
      v: JoinOps[C, Q, R],
      prefix: String,
      other: Joinable[Q2, R2],
      on: Option[(Q, Q2) => Expr[Boolean]]
  )(
      implicit ja: JoinAppend[Q, Q2, QF, RF]
  ) = ...
```

#### `Joinable.scala`

> Something that can be joined; typically a [[Select]] or a [[Table]]

```scala
trait Joinable[Q, R]
```

> Version of `crossJoin` meant for usage in `for`-comprehensions

```scala
def crossJoin[Q2, R2](): FlatJoin.Mapper[Q, Q2, R, R2] = ...
```

> Version of `join` meant for usage in `for`-comprehensions

```scala
def join[Q2, R2](on: Q => Expr[Boolean]): FlatJoin.Mapper[Q, Q2, R, R2] = ...
```

> Version of `leftJoin` meant for usage in `for`-comprehensions

```scala
def leftJoin[Q2, R2](on: Q => Expr[Boolean]): FlatJoin.NullableMapper[Q, Q2, R, R2] = ...
```

```scala
object Joinable
```

```scala
def toFromExpr[Q, R](x: Joinable[Q, R]) = ...
```

#### `JoinsToSql.scala`

```scala
object JoinsToSql
```

```scala
def joinsToSqlStr(
      joins: Seq[Join],
      renderedFroms: Map[Context.From, SqlStr],
      joinOns: Seq[Seq[Option[SqlStr.Flattened]]]
  ) = ...
```

```scala
def renderFroms(
      selectables: Seq[Context.From],
      prevContext: Context,
      namedFromsMap: Map[Context.From, String],
      liveExprs: LiveExprs
  ) = ...
```

```scala
def renderSingleFrom(
      prevContext: Context,
      liveExprs: LiveExprs,
      f: Context.From,
      namedFromsMap: Map[Context.From, String]
  ): SqlStr = ...
```

```scala
def renderLateralJoins(
      prevContext: Context,
      from: Seq[Context.From],
      innerLiveExprs: LiveExprs,
      joins0: Seq[Join],
      renderedJoinOns: Seq[Seq[Option[SqlStr.Flattened]]]
  ) = ...
```

#### `LateralJoinOps.scala`

> Wrapper class with extension methods to add support for `JOIN LATERAL`, which
> allow for `JOIN` clauses to access the results of earlier `JOIN` and `FROM` clauses.
> Only supported by Postgres and MySql

```scala
class LateralJoinOps[C[_, _], Q, R](wrapped: JoinOps[C, Q, R] & Joinable[Q, R])(
    implicit qr: Queryable.Row[Q, R]
)
```

> Performs a `CROSS JOIN LATERAL`, similar to `CROSS JOIN` but allows the
> `JOIN` clause to access the results of earlier `JOIN` and `FROM` clauses.
> Only supported by Postgres and MySql

```scala
def crossJoinLateral[Q2, R2, QF, RF](other: Q => Joinable[Q2, R2])(
      implicit ja: JoinAppend[Q, Q2, QF, RF]
  ): C[QF, RF] = ...
```

> Performs a `JOIN LATERAL`, similar to `JOIN` but allows the
> `JOIN` clause to access the results of earlier `JOIN` and `FROM` clauses.
> Only supported by Postgres and MySql

```scala
def joinLateral[Q2, R2, QF, RF](other: Q => Joinable[Q2, R2])(on: (Q, Q2) => Expr[Boolean])(
      implicit ja: JoinAppend[Q, Q2, QF, RF]
  ): C[QF, RF] = ...
```

```scala
def leftJoinLateral[Q2, R2](other: Q => Joinable[Q2, R2])(
      on: (Q, Q2) => Expr[Boolean]
  )(implicit joinQr: Queryable.Row[Q2, R2]): Select[(Q, JoinNullable[Q2]), (R, Option[R2])] = ...
```

> Version of `crossJoinLateral` meant for use in `for`-comprehensions

```scala
def crossJoinLateral[Q2, R2](): FlatJoin.Mapper[Q, Q2, R, R2] = ...
```

> Version of `joinLateral` meant for use in `for`-comprehensions

```scala
def joinLateral[Q2, R2](on: Q => Expr[Boolean]): FlatJoin.Mapper[Q, Q2, R, R2] = ...
```

> Version of `leftJoinLateral` meant for use in `for`-comprehensions

```scala
def leftJoinLateral[Q2, R2](on: Q => Expr[Boolean]): FlatJoin.NullableMapper[Q, Q2, R, R2] = ...
```

#### `Model.scala`

> Models a SQL `ORDER BY` clause

```scala
case class OrderBy(expr: Expr[?], ascDesc: Option[AscDesc], nulls: Option[Nulls])
```

```scala
sealed trait AscDesc
```

```scala
object AscDesc
```

> Models a SQL `ASC` clause

```scala
case object Asc extends AscDesc
```

> Models a SQL `DESC` clause

```scala
case object Desc extends AscDesc
```

```scala
sealed trait Nulls
```

```scala
object Nulls
```

> Models a SQL `NULLS FIRST` clause

```scala
case object First extends Nulls
```

> Models a SQL `NULSL LAST` clause

```scala
case object Last extends Nulls
```

> Models a SQL `GROUP BY` clause

```scala
case class GroupBy(keys: Seq[Expr[?]], select: () => Select[?, ?], having: Seq[Expr[?]])
```

> Models a SQL `JOIN` clause

```scala
case class Join(prefix: String, from: Seq[Join.From])
```

```scala
object Join
```

```scala
case class From(from: scalasql.core.Context.From, on: Option[Expr[?]])
```

#### `OnConflict.scala`

> A query with a SQL `ON CONFLICT` clause, typically an `INSERT` or an `UPDATE`

```scala
class OnConflict[Q, R](query: Query[R] & Returning.InsertBase[Q], expr: Q, table: TableRef)
```

```scala
def onConflictIgnore(c: (Q => Column[?])*) = ...
```

```scala
def onConflictUpdate(c: (Q => Column[?])*)(c2: (Q => Column.Assignment[?])*) = ...
```

```scala
object OnConflict
```

```scala
class Ignore[Q, R](
      protected val query: Query[R] & Returning.InsertBase[Q],
      columns: Seq[Column[?]],
      val table: TableRef
  ) extends Query.DelegateQuery[R]
      with Returning.InsertBase[Q]
```

```scala
class Update[Q, R](
      protected val query: Query[R] & Returning.InsertBase[Q],
      columns: Seq[Column[?]],
      updates: Seq[Column.Assignment[?]],
      val table: TableRef
  ) extends Query.DelegateQuery[R]
      with Returning.InsertBase[Q]
```

#### `Query.scala`

> A SQL Query, either a [[Query.Multiple]] that returns multiple rows, or
> a [[Query.Single]] that returns a single row

```scala
trait Query[R] extends Renderable
```

```scala
object Query
```

> Configuration for a typical update [[Query]]

```scala
trait ExecuteUpdate[R] extends scalasql.query.Query[R]
```

> Configuration for a [[Query]] that wraps another [[Query]], delegating
> most of the abstract methods to it

```scala
trait DelegateQuery[R] extends scalasql.query.Query[R]
```

> Configuration for a [[Query]] that wraps an expr [[Q]] and [[Queryable]]

```scala
trait DelegateQueryable[Q, R] extends scalasql.query.Query[R] with WithSqlExpr[Q]
```

```scala
implicit def QueryQueryable[R]: Queryable[Query[R], R] = ...
```

```scala
def walkLabels[R](q: Query[R]) = ...
```

```scala
def walkSqlExprs[R](q: Query[R]) = ...
```

```scala
def isSingleRow[R](q: Query[R]) = ...
```

```scala
def construct[R](q: Query[R], args: Queryable.ResultSetIterator) = ...
```

> The default [[Queryable]] instance for any [[Query]]. Delegates the implementation
> of the [[Queryable]] methods to abstract methods on the [[Query]], to allow easy
> overrides and subclassing of [[Query]] classes

```scala
class QueryQueryable[Q <: Query[R], R]() extends scalasql.core.Queryable[Q, R] {
    override def isGetGeneratedKeys(q: Q) = ...
```

```scala
override def isExecuteUpdate(q: Q) = ...
```

```scala
override def walkLabels(q: Q) = ...
```

```scala
override def walkExprs(q: Q) = ...
```

```scala
override def isSingleRow(q: Q) = ...
```

```scala
def renderSql(q: Q, ctx: Context): SqlStr = ...
```

```scala
override def construct(q: Q, args: Queryable.ResultSetIterator): R = ...
```

> A [[Query]] that wraps another [[Query]] but sets [[queryIsSingleRow]] to `true`

```scala
class Single[R](protected val query: Query[Seq[R]]) extends Query.DelegateQuery[R]
```

#### `Returning.scala`

> A query with a `RETURNING` clause

```scala
trait Returning[Q, R] extends Query[Seq[R]] with Query.DelegateQueryable[Q, Seq[R]]
```

```scala
def single: Query.Single[R] = ...
```

```scala
object Returning
```

> A query that could support a `RETURNING` clause, typically
> an `INSERT` or `UPDATE`

```scala
trait Base[Q] extends Renderable with WithSqlExpr[Q]
```

```scala
def table: TableRef
```

```scala
trait InsertBase[Q] extends Base[Q]
```

> Makes this `INSERT` query call `JdbcStatement.getGeneratedKeys` when it is executed,
> returning a `Seq[R]` where `R` is a Scala type compatible with the auto-generated
> primary key type (typically something like `Int` or `Long`)

```scala
def getGeneratedKeys[R](implicit qr: Queryable.Row[?, R]): GetGeneratedKeys[Q, R] = ...
```

```scala
class InsertImpl[Q, R](returnable: InsertBase[?], returning: Q)(
      implicit qr: Queryable.Row[Q, R]
  ) extends Returning.Impl0[Q, R](qr, returnable, returning)
```

```scala
class Impl[Q, R](returnable: Base[?], returning: Q)(implicit qr: Queryable.Row[Q, R])
```

```scala
class Impl0[Q, R](
      protected val qr: Queryable.Row[Q, R],
      returnable: Base[?],
      protected val expr: Q
  ) extends Returning[Q, R]
```

```scala
override def queryIsSingleRow = ...
```

#### `Select.scala`

> A SQL `SELECT` query, possible with `JOIN`, `WHERE`, `GROUP BY`,
> `ORDER BY`, `LIMIT`, `OFFSET` clauses
>
> Models the various components of a SQL SELECT:
>
> {{{
> SELECT DISTINCT column, AGG_FUNC(column_or_expression), …
> FROM mytable
> JOIN another_table ON mytable.column = another_table.column
> WHERE constraint_expression
> GROUP BY column HAVING constraint_expression
> ORDER BY column ASC/DESC
> LIMIT count OFFSET COUNT;
> }}}
>
> Good syntax reference:
>
> https://www.cockroachlabs.com/docs/stable/selection-queries#set-operations
> https://www.postgresql.org/docs/current/sql-select.html

```scala
trait Select[Q, R]
    extends SqlStr.Renderable
    with Aggregatable[Q]
    with Joinable[Q, R]
    with JoinOps[Select, Q, R]
    with Query[Seq[R]]
    with Query.DelegateQueryable[Q, Seq[R]]
    with SubqueryRef.Wrapped
```

```scala
def qr: Queryable.Row[Q, R]
```

> Causes this [[Select]] to ignore duplicate rows, translates into SQL `SELECT DISTINCT`

```scala
def distinct: Select[Q, R] = ...
```

> Transforms the return value of this [[Select]] with the given function

```scala
def map[Q2, R2](f: Q => Q2)(implicit qr: Queryable.Row[Q2, R2]): Select[Q2, R2]
```

> Performs an implicit `JOIN` between this [[Select]] and the one returned by the
> callback function [[f]]

```scala
def flatMap[Q2, R2](f: Q => FlatJoin.Rhs[Q2, R2])(
      implicit qr: Queryable.Row[Q2, R2]
  ): Select[Q2, R2]
```

> Filters this [[Select]] with the given predicate, translates into a SQL `WHERE` clause

```scala
def filter(f: Q => Expr[Boolean]): Select[Q, R]
```

> Alias for [[filter]]

```scala
def withFilter(f: Q => Expr[Boolean]): Select[Q, R] = ...
```

> Filters this [[Select]] with the given predicate, if [[cond]] evaluates to true

```scala
def filterIf(cond: Boolean)(
      f: Q => Expr[Boolean]
  ): Select[Q, R]
```

> Filters this [[Select]] with the given predicate consuming provided option as a part of predicate's input,
> if this option is Some[T]

```scala
def filterOpt[T](option: Option[T])(
      f: (Q, T) => Expr[Boolean]
  ): Select[Q, R]
```

> Performs one or more aggregates in a single [[Select]]

```scala
def aggregate[E, V](f: Aggregatable.Proxy[Q] => E)(
      implicit qr: Queryable.Row[E, V]
  ): Aggregate[E, V]
```

> Performs a `.map` which additionally provides a [[Aggregatable.Proxy]] that allows you to perform aggregate
> functions.

```scala
def mapAggregate[Q2, R2](f: (Q, Aggregatable.Proxy[Q]) => Q2)(
      implicit qr: Queryable.Row[Q2, R2]
  ): Select[Q2, R2]
```

> Translates into a SQL `GROUP BY`, takes a function specifying the group-key and
> a function specifying the group-aggregate.

```scala
def groupBy[K, V, R2, R3](groupKey: Q => K)(
      groupAggregate: Aggregatable.Proxy[Q] => V
  )(implicit qrk: Queryable.Row[K, R2], qrv: Queryable.Row[V, R3]): Select[(K, V), (R2, R3)]
```

> Sorts this [[Select]] via the given expression. Translates into a SQL `ORDER BY`
> clause. Can be called more than once to sort on multiple columns, with the last
> call to [[sortBy]] taking priority. Can be followed by [[asc]], [[desc]], [[nullsFirst]]
> or [[nullsLast]] to configure the sort order

```scala
def sortBy(f: Q => Expr[?]): Select[Q, R]
```

> Combined with [[sortBy]] to make the sort order ascending, translates into SQL `ASC`

```scala
def asc: Select[Q, R]
```

> Combined with [[sortBy]] to make the sort order descending, translates into SQL `DESC`

```scala
def desc: Select[Q, R]
```

> Combined with [[sortBy]] to configure handling of nulls, translates into SQL `NULLS FIRST`

```scala
def nullsFirst: Select[Q, R]
```

> Combined with [[sortBy]] to configure handling of nulls, translates into SQL `NULLS LAST`

```scala
def nullsLast: Select[Q, R]
```

> Concatenates the result rows of this [[Select]] with another and removes duplicate
> rows; translates into SQL `UNION`

```scala
def union(other: Select[Q, R]): Select[Q, R] = ...
```

> Concatenates the result rows of this [[Select]] with another; translates into SQL
> `UNION ALL`

```scala
def unionAll(other: Select[Q, R]): Select[Q, R] = ...
```

> Intersects the result rows of this [[Select]] with another, preserving only rows
> present in both this and the [[other]] and removing duplicates. Translates
> into SQL `INTERSECT`

```scala
def intersect(other: Select[Q, R]): Select[Q, R] = ...
```

> Subtracts the [[other]] from this [[Select]], returning only rows present this
> but absent in [[other]], and removing duplicates. Translates into SQL `EXCEPT`

```scala
def except(other: Select[Q, R]): Select[Q, R] = ...
```

> Drops the first [[n]] rows from this [[Select]]. Like when used in Scala collections,
> if called multiple times the dropped rows add up

```scala
def drop(n: Int): Select[Q, R]
```

> Only returns the first [[n]] rows from this [[Select]]. Like when used in Scala collections,
> if called multiple times only the smallest value of [[n]] takes effect

```scala
def take(n: Int): Select[Q, R]
```

> Asserts that this query returns exactly one row, and returns a single
> value of type [[R]] rather than a `Seq[R]`. Throws an exception if
> zero or multiple rows are returned.

```scala
def single: Query.Single[R] = ...
```

> Shorthand for `.take(1).single`:
>
> 1. If the query returns a single row, this returns it as a single value of type [[R]]
> 2. If the query returns multiple rows, returns the first as a single value of type [[R]]
> and discards the rest
> 3. If the query returns zero rows, throws an exception.

```scala
def head: Query.Single[R] = ...
```

> Converts this [[Select]] into an [[Expr]], assuming it returns a single row and
> a single column. Note that if this returns multiple rows, behavior is database-specific,
> with some like Sqlite simply taking the first row while others like Postgres/MySql
> throwing exceptions

```scala
def toExpr(implicit mt: TypeMapper[R]): Expr[R] = ...
```

> Forces this [[Select]] to be treated as a subquery that any further operations
> will operate on, rather than having some operations flattened out into clauses
> in this [[Select]]

```scala
def subquery: SimpleSelect[Q, R] = ...
```

> Performs a `LEFT JOIN` on the given [[other]], typically a [[Table]] or [[Select]].

```scala
def leftJoin[Q2, R2](other: Joinable[Q2, R2])(on: (Q, Q2) => Expr[Boolean])(
      implicit joinQr: Queryable.Row[Q2, R2]
  ): Select[(Q, JoinNullable[Q2]), (R, Option[R2])]
```

> Performs a `RIGHT JOIN` on the given [[other]], typically a [[Table]] or [[Select]].

```scala
def rightJoin[Q2, R2](other: Joinable[Q2, R2])(on: (Q, Q2) => Expr[Boolean])(
      implicit joinQr: Queryable.Row[Q2, R2]
  ): Select[(JoinNullable[Q], Q2), (Option[R], R2)]
```

> Performs a `OUTER JOIN` on the given [[other]], typically a [[Table]] or [[Select]].

```scala
def outerJoin[Q2, R2](other: Joinable[Q2, R2])(on: (Q, Q2) => Expr[Boolean])(
      implicit joinQr: Queryable.Row[Q2, R2]
  ): Select[(JoinNullable[Q], JoinNullable[Q2]), (Option[R], Option[R2])]
```

> Returns whether or not the [[Select]] on the left contains the [[other]] value on the right

```scala
def contains(other: Q): Expr[Boolean] = ...
```

> Returns whether or not the [[Select]] on the left is empty with zero elements

```scala
def isEmpty: Expr[Boolean] = ...
```

> Returns whether or not the [[Select]] on the left is nonempty with one or more elements

```scala
def nonEmpty: Expr[Boolean] = ...
```

```scala
object Select
```

```scala
def newSimpleSelect[Q, R](
      lhs: Select[Q, R],
      expr: Q,
      exprPrefix: Option[Context => SqlStr],
      exprSuffix: Option[Context => SqlStr],
      preserveAll: Boolean,
      from: Seq[Context.From],
      joins: Seq[Join],
      where: Seq[Expr[?]],
      groupBy0: Option[GroupBy]
  )(implicit qr: Queryable.Row[Q, R], dialect: DialectTypeMappers): SimpleSelect[Q, R] = ...
```

```scala
def toSimpleFrom[Q, R](s: Select[Q, R]) = ...
```

```scala
def withExprPrefix[Q, R](s: Select[Q, R], preserveAll: Boolean, str: Context => SqlStr) = ...
```

```scala
def withExprSuffix[Q, R](s: Select[Q, R], preserveAll: Boolean, str: Context => SqlStr) = ...
```

```scala
implicit class ExprSelectOps[T](s: Select[Expr[T], T])
```

```scala
def sorted(implicit tm: TypeMapper[T]): Select[Expr[T], T] = ...
```

```scala
trait Proxy[Q, R] extends Select[Q, R]
```

```scala
override def qr: Queryable.Row[Q, R]
```

```scala
override def map[Q2, R2](f: Q => Q2)(implicit qr: Queryable.Row[Q2, R2]): Select[Q2, R2] = ...
```

```scala
override def flatMap[Q2, R2](f: Q => FlatJoin.Rhs[Q2, R2])(
        implicit qr: Queryable.Row[Q2, R2]
    ): Select[Q2, R2] = ...
```

```scala
override def filter(f: Q => Expr[Boolean]): Select[Q, R] = ...
```

```scala
override def filterIf(cond: Boolean)(f: Q => Expr[Boolean]): Select[Q, R] = ...
```

```scala
override def filterOpt[T](option: Option[T])(f: (Q, T) => Expr[Boolean]): Select[Q, R] = ...
```

```scala
override def aggregate[E, V](f: Aggregatable.Proxy[Q] => E)(
        implicit qr: Queryable.Row[E, V]
    ): Aggregate[E, V] = ...
```

```scala
override def mapAggregate[Q2, R2](f: (Q, Aggregatable.Proxy[Q]) => Q2)(
        implicit qr: Queryable.Row[Q2, R2]
    ): Select[Q2, R2] = ...
```

```scala
override def groupBy[K, V, R2, R3](groupKey: Q => K)(
        groupAggregate: Aggregatable.Proxy[Q] => V
    )(implicit qrk: Queryable.Row[K, R2], qrv: Queryable.Row[V, R3]): Select[(K, V), (R2, R3)] = ...
```

```scala
override def sortBy(f: Q => Expr[?]): Select[Q, R] = ...
```

```scala
override def asc: Select[Q, R] = ...
```

```scala
override def desc: Select[Q, R] = ...
```

```scala
override def nullsFirst: Select[Q, R] = ...
```

```scala
override def nullsLast: Select[Q, R] = ...
```

```scala
override def drop(n: Int): Select[Q, R] = ...
```

```scala
override def take(n: Int): Select[Q, R] = ...
```

```scala
override def leftJoin[Q2, R2](other: Joinable[Q2, R2])(on: (Q, Q2) => Expr[Boolean])(
        implicit joinQr: Queryable.Row[Q2, R2]
    ): Select[(Q, JoinNullable[Q2]), (R, Option[R2])] = ...
```

```scala
override def rightJoin[Q2, R2](other: Joinable[Q2, R2])(on: (Q, Q2) => Expr[Boolean])(
        implicit joinQr: Queryable.Row[Q2, R2]
    ): Select[(JoinNullable[Q], Q2), (Option[R], R2)] = ...
```

```scala
override def outerJoin[Q2, R2](other: Joinable[Q2, R2])(on: (Q, Q2) => Expr[Boolean])(
        implicit joinQr: Queryable.Row[Q2, R2]
    ): Select[(JoinNullable[Q], JoinNullable[Q2]), (Option[R], Option[R2])] = ...
```

```scala
override def aggregateExpr[V: TypeMapper](f: Q => Context => SqlStr)(
        implicit qr: Queryable.Row[Expr[V], V]
    ): Expr[V] = ...
```

#### `SimpleSelect.scala`

> A `SELECT` query, with `FROM`/`JOIN`/`WHERE`/`GROUP BY`
> clauses, but without `ORDER BY`/`LIMIT`/`TAKE`/`UNION` clauses

```scala
class SimpleSelect[Q, R](
    val expr: Q,
    val exprPrefix: Option[Context => SqlStr],
    val exprSuffix: Option[Context => SqlStr],
    val preserveAll: Boolean,
    val from: Seq[Context.From],
    val joins: Seq[Join],
    val where: Seq[Expr[?]],
    val groupBy0: Option[GroupBy]
)(implicit val qr: Queryable.Row[Q, R], protected val dialect: DialectTypeMappers)
```

```scala
def selectWithExprPrefix(preserveAll: Boolean, s: Context => SqlStr): Select[Q, R] = ...
```

```scala
def selectWithExprSuffix(preserveAll: Boolean, s: Context => SqlStr): Select[Q, R] = ...
```

```scala
def aggregateExpr[V: TypeMapper](
      f: Q => Context => SqlStr
  )(implicit qr2: Queryable.Row[Expr[V], V]): Expr[V] = ...
```

```scala
def map[Q2, R2](f: Q => Q2)(implicit qr: Queryable.Row[Q2, R2]): SimpleSelect[Q2, R2] = ...
```

```scala
def flatMap[Q2, R2](
      f: Q => FlatJoin.Rhs[Q2, R2]
  )(implicit qr2: Queryable.Row[Q2, R2]): Select[Q2, R2] = ...
```

```scala
def filter(f: Q => Expr[Boolean]): Select[Q, R] = ...
```

```scala
def filterIf(cond: Boolean)(f: Q => Expr[Boolean]): Select[Q, R] = ...
```

```scala
def filterOpt[T](option: Option[T])(f: (Q, T) => Expr[Boolean]): Select[Q, R] = ...
```

```scala
def join0[Q2, R2, QF, RF](
      prefix: String,
      other: Joinable[Q2, R2],
      on: Option[(Q, Q2) => Expr[Boolean]]
  )(
      implicit ja: JoinAppend[Q, Q2, QF, RF]
  ): Select[QF, RF] = ...
```

```scala
def leftJoin[Q2, R2](other: Joinable[Q2, R2])(
      on: (Q, Q2) => Expr[Boolean]
  )(implicit joinQr: Queryable.Row[Q2, R2]): Select[(Q, JoinNullable[Q2]), (R, Option[R2])] = ...
```

```scala
def rightJoin[Q2, R2](other: Joinable[Q2, R2])(
      on: (Q, Q2) => Expr[Boolean]
  )(implicit joinQr: Queryable.Row[Q2, R2]): Select[(JoinNullable[Q], Q2), (Option[R], R2)] = ...
```

```scala
def outerJoin[Q2, R2](other: Joinable[Q2, R2])(on: (Q, Q2) => Expr[Boolean])(
      implicit joinQr: Queryable.Row[Q2, R2]
  ): Select[(JoinNullable[Q], JoinNullable[Q2]), (Option[R], Option[R2])] = ...
```

```scala
def aggregate[E, V](
      f: Aggregatable.Proxy[Q] => E
  )(implicit qr: Queryable.Row[E, V]): Aggregate[E, V] = ...
```

```scala
def mapAggregate[Q2, R2](
      f: (Q, Aggregatable.Proxy[Q]) => Q2
  )(implicit qr: Queryable.Row[Q2, R2]): Select[Q2, R2] = ...
```

```scala
def groupBy[K, V, R1, R2](groupKey: Q => K)(
      groupAggregate: Aggregatable.Proxy[Q] => V
  )(implicit qrk: Queryable.Row[K, R1], qrv: Queryable.Row[V, R2]): Select[(K, V), (R1, R2)] = ...
```

```scala
def sortBy(f: Q => Expr[?]): Select[Q, R] = ...
```

```scala
def asc: Select[Q, R] = ...
```

```scala
def desc: Select[Q, R] = ...
```

```scala
def nullsFirst: Select[Q, R] = ...
```

```scala
def nullsLast: Select[Q, R] = ...
```

```scala
def compound0(op: String, other: Select[Q, R]) = ...
```

```scala
def drop(n: Int): Select[Q, R] = ...
```

```scala
def take(n: Int): Select[Q, R] = ...
```

```scala
object SimpleSelect
```

```scala
def joinCopy[Q, R, Q2, R2, Q3, R3](
      self: SimpleSelect[Q, R],
      other: Joinable[Q2, R2],
      on: Option[(Q, Q2) => Expr[Boolean]],
      joinPrefix: String
  )(f: (Q, Q2) => Q3)(implicit jqr: Queryable.Row[Q3, R3]) = ...
```

```scala
def getRenderer(s: SimpleSelect[?, ?], prevContext: Context): SimpleSelect.Renderer[?, ?] = ...
```

```scala
class Renderer[Q, R](query: SimpleSelect[Q, R], prevContext: Context)
```

```scala
lazy val flattenedExpr = ...
```

```scala
lazy val froms = ...
```

```scala
implicit lazy val context: Context = ...
```

```scala
lazy val joinOns = ...
```

```scala
lazy val exprsStrs = ...
```

```scala
lazy val filtersOpt = ...
```

```scala
lazy val groupByOpt = ...
```

```scala
def render(liveExprs0: LiveExprs) = ...
```

#### `SqlWindow.scala`

```scala
case class SqlWindow[T](
    e: Expr[T],
    partitionBy0: Option[Expr[?]],
    filter0: Option[Expr[Boolean]],
    orderBy: Seq[scalasql.query.OrderBy],
    frameStart0: Option[SqlStr],
    frameEnd0: Option[SqlStr],
    exclusions: Option[SqlStr]
)(implicit dialect: DialectTypeMappers)
```

```scala
def partitionBy(e: Expr[?]) = ...
```

```scala
def filter(expr: Expr[Boolean]) = ...
```

```scala
def sortBy(expr: Expr[?]) = ...
```

```scala
def asc = ...
```

```scala
def desc = ...
```

```scala
def nullsFirst = ...
```

```scala
def nullsLast = ...
```

```scala
class FrameConfig(f: Some[SqlStr] => SqlWindow[T])
```

```scala
def preceding(offset: Int = -1) = ...
```

```scala
def currentRow = ...
```

```scala
def following(offset: Int = -1) = ...
```

```scala
def frameStart = ...
```

```scala
def frameEnd = ...
```

```scala
object exclude
```

```scala
def currentRow = ...
```

```scala
def group = ...
```

```scala
def ties = ...
```

```scala
def noOthers = ...
```

#### `Table.scala`

> In-code representation of a SQL table, associated with a given `case class` [[V]].

```scala
abstract class Table[V[_[_]]]()(implicit name: sourcecode.Name, metadata0: Table.Metadata[V])
```

```scala
implicit def containerQr(implicit dialect: DialectTypeMappers): Queryable.Row[V[Expr], V[Sc]] = ...
```

```scala
implicit def tableImplicitMetadata: Table.ImplicitMetadata[V] = ...
```

```scala
object Table
```

```scala
trait LowPri[V[_[_]]]
```

```scala
implicit def containerQr2(
        implicit dialect: DialectTypeMappers
    ): Queryable.Row[V[Column], V[Sc]] = ...
```

```scala
case class ImplicitMetadata[V[_[_]]](value: Metadata[V])
```

```scala
def metadata[V[_[_]]](t: Table[V]) = ...
```

```scala
def ref[V[_[_]]](t: Table[V]) = ...
```

```scala
def name(t: Table.Base) = ...
```

```scala
def labels(t: Table.Base) = ...
```

```scala
def columnNameOverride[V[_[_]]](t: Table.Base)(s: String) = ...
```

```scala
def identifier(t: Table.Base)(implicit context: Context): String = ...
```

```scala
def fullIdentifier(
      t: Table.Base
  )(implicit context: Context): String = ...
```

```scala
trait Base
```

```scala
class Metadata[V[_[_]]](
      val queryables: (DialectTypeMappers, Int) => Queryable.Row[?, ?],
      val walkLabels0: () => Seq[String],
      val queryable: (
          () => Seq[String],
          DialectTypeMappers,
          Metadata.QueryableProxy
      ) => Queryable[V[Expr], V[Sc]],
      val vExpr0: (TableRef, DialectTypeMappers, Metadata.QueryableProxy) => V[Column]
  )
```

```scala
def vExpr(t: TableRef, d: DialectTypeMappers) = ...
```

```scala
object Metadata extends scalasql.query.TableMacros
```

```scala
class QueryableProxy(queryables: Int => Queryable.Row[?, ?])
```

```scala
def apply[T, V](n: Int): Queryable.Row[T, V] = ...
```

```scala
object Internal
```

```scala
class TableQueryable[Q, R <: scala.Product](
        walkLabels0: () => Seq[String],
        walkExprs0: Q => Seq[Expr[?]],
        construct0: Queryable.ResultSetIterator => R,
        deconstruct0: R => Q = ???
    ) extends Queryable.Row[Q, R]
```

```scala
def walkLabels(): Seq[List[String]] = ...
```

```scala
def walkExprs(q: Q): Seq[Expr[?]] = ...
```

```scala
def construct(args: Queryable.ResultSetIterator) = ...
```

```scala
def deconstruct(r: R): Q = ...
```

#### `TableMacros.scala`

```scala
object TableMacros
```

```scala
def applyImpl[V[_[_]] <: Product](using Quotes, Type[V]): Expr[Table.Metadata[V]] = {
    import quotes.reflect.*
```

```scala
trait TableMacros
```

```scala
inline given initTableMetadata[V[_[_]] <: Product]: Table.Metadata[V] = ${
    TableMacros.applyImpl[V]
```

#### `Update.scala`

> A SQL `UPDATE` query

```scala
trait Update[Q, R]
    extends JoinOps[Update, Q, R]
    with Returning.Base[Q]
    with Query.ExecuteUpdate[Int]
```

```scala
def filter(f: Q => Expr[Boolean]): Update[Q, R]
```

```scala
def withFilter(f: Q => Expr[Boolean]): Update[Q, R] = ...
```

```scala
def set(f: (Q => Column.Assignment[?])*): Update[Q, R]
```

```scala
def join0[Q2, R2, QF, RF](
      prefix: String,
      other: Joinable[Q2, R2],
      on: Option[(Q, Q2) => Expr[Boolean]]
  )(
      implicit ja: JoinAppend[Q, Q2, QF, RF]
  ): Update[QF, RF]
```

```scala
def qr: Queryable.Row[Q, R]
```

```scala
object Update
```

> Syntax reference
>
> https://www.postgresql.org/docs/current/sql-update.html

```scala
class Impl[Q, R](
      val expr: Q,
      val table: TableRef,
      val set0: Seq[Column.Assignment[?]],
      val joins: Seq[Join],
      val where: Seq[Expr[?]]
  )(implicit val qr: Queryable.Row[Q, R], dialect: DialectTypeMappers)
```

```scala
def filter(f: Q => Expr[Boolean]) = ...
```

```scala
def set(f: (Q => Column.Assignment[?])*) = ...
```

```scala
def join0[Q2, R2, QF, RF](
        prefix: String,
        other: Joinable[Q2, R2],
        on: Option[(Q, Q2) => Expr[Boolean]]
    )(
        implicit ja: JoinAppend[Q, Q2, QF, RF]
    ) = ...
```

```scala
class Renderer(
      joins0: Seq[Join],
      table: TableRef,
      set0: Seq[Column.Assignment[?]],
      where0: Seq[Expr[?]],
      prevContext: Context
  )
```

```scala
lazy val froms = ...
```

```scala
lazy val contextStage1: Context = ...
```

```scala
implicit lazy val context: Context = ...
```

```scala
lazy val updateList = ...
```

```scala
lazy val sets = ...
```

```scala
lazy val where = ...
```

```scala
lazy val liveExprs = ...
```

```scala
lazy val renderedFroms = ...
```

```scala
lazy val from = ...
```

```scala
lazy val fromOns = ...
```

```scala
lazy val joinOns = ...
```

```scala
lazy val joins = ...
```

```scala
lazy val tableName = ...
```

```scala
def render() = ...
```

#### `Values.scala`

> A SQL `VALUES` clause, used to treat a sequence of primitive [[T]]s as
> a [[Select]] query.

```scala
class Values[Q, R](val ts: Seq[R])(
    implicit val qr: Queryable.Row[Q, R],
    protected val dialect: DialectTypeMappers
) extends Select.Proxy[Q, R]
    with Query.DelegateQueryable[Q, Seq[R]]
```

```scala
val tableRef = ...
```

```scala
object Values
```

```scala
class Renderer[Q, R](v: Values[Q, R])(implicit qr: Queryable.Row[Q, R], ctx: Context)
```

```scala
def wrapRow(t: R): SqlStr = ...
```

```scala
def render(liveExprs: LiveExprs): SqlStr = ...
```

```scala
def context = ...
```

#### `WithCte.scala`

> A SQL `WITH` clause

```scala
class WithCte[Q, R](
    walked: Queryable.Walked,
    val lhs: Select[?, ?],
    val cteRef: WithCteRef,
    val rhs: Select[Q, R],
    val withPrefix: SqlStr = sql"WITH "
)(implicit val qr: Queryable.Row[Q, R], protected val dialect: DialectTypeMappers)
```

```scala
override def map[Q2, R2](f: Q => Q2)(implicit qr2: Queryable.Row[Q2, R2]): Select[Q2, R2] = ...
```

```scala
override def filter(f: Q => Expr[Boolean]): Select[Q, R] = ...
```

```scala
override def sortBy(f: Q => Expr[?]): Select[Q, R] = ...
```

```scala
override def drop(n: Int): Select[Q, R] = ...
```

```scala
override def take(n: Int): Select[Q, R] = ...
```

```scala
object WithCte
```

```scala
class Proxy[Q, R](
      lhs: Select[Q, R],
      lhsSubQueryRef: WithCteRef,
      val qr: Queryable.Row[Q, R],
      protected val dialect: DialectTypeMappers
  ) extends Select.Proxy[Q, R]
```

```scala
override def joinableToFromExpr: (Context.From, Q) = ...
```

```scala
override def selectRenderer(prevContext: Context): SubqueryRef.Wrapped.Renderer = ...
```

```scala
class Renderer[Q, R](
      walked: Queryable.Walked,
      withPrefix: SqlStr,
      query: WithCte[Q, R],
      prevContext: Context
  ) extends SubqueryRef.Wrapped.Renderer
```

```scala
def render(liveExprs: LiveExprs) = ...
```

### `com.lihaoyi:scalasql-operations_3:0.3.1`

Source: https://repo1.maven.org/maven2/com/lihaoyi/scalasql-operations_3/0.3.1/scalasql-operations_3-0.3.1-sources.jar

#### `AggAnyOps.scala`

> Aggregations that apply to any element type `T`, e.g. COUNT and COUNT(DISTINCT)
> over an aggregated `Expr[T]` sequence.

```scala
class AggAnyOps[T](v: Aggregatable[Expr[T]])(
    implicit tmInt: TypeMapper[Int],
    qrInt: Queryable.Row[Expr[Int], Int]
)
```

> Counts non-null values

```scala
def count: Expr[Int] = ...
```

> Counts distinct non-null values

```scala
def countDistinct: Expr[Int] = ...
```

#### `AggNumericOps.scala`

```scala
class AggNumericOps[V: Numeric: TypeMapper](v: Aggregatable[Expr[V]])(
    implicit qr: Queryable.Row[Expr[V], V]
)
```

> Computes the sum of column values

```scala
def sum: Expr[V] = ...
```

> Finds the minimum value in a column

```scala
def min: Expr[V] = ...
```

> Finds the maximum value in a column

```scala
def max: Expr[V] = ...
```

> Computes the average value of a column

```scala
def avg: Expr[V] = ...
```

#### `AggOps.scala`

```scala
class AggOps[T](v: Aggregatable[T])(implicit qr: Queryable.Row[T, ?], dialect: DialectTypeMappers)
```

> Counts the rows

```scala
def size: Expr[Int] = ...
```

> Counts non-null values in the selected column

```scala
def countBy[V](f: T => Expr[V])(implicit qrInt: Queryable.Row[Expr[Int], Int]): Expr[Int] = ...
```

> Counts distinct non-null values in the selected column

```scala
def countDistinctBy[V](
      f: T => Expr[V]
  )(implicit qrInt: Queryable.Row[Expr[Int], Int]): Expr[Int] = ...
```

> Computes the sum of column values

```scala
def sumBy[V: TypeMapper](f: T => Expr[V])(
      implicit qr: Queryable.Row[Expr[V], V]
  ): Expr[V] = ...
```

> Finds the minimum value in a column

```scala
def minBy[V: TypeMapper](f: T => Expr[V])(
      implicit qr: Queryable.Row[Expr[V], V]
  ): Expr[V] = ...
```

> Finds the maximum value in a column

```scala
def maxBy[V: TypeMapper](f: T => Expr[V])(
      implicit qr: Queryable.Row[Expr[V], V]
  ): Expr[V] = ...
```

> Computes the average value of a column

```scala
def avgBy[V: TypeMapper](f: T => Expr[V])(
      implicit qr: Queryable.Row[Expr[V], V]
  ): Expr[V] = ...
```

> Computes the sum of column values

```scala
def sumByOpt[V: TypeMapper](f: T => Expr[V])(
      implicit qr: Queryable.Row[Expr[V], V]
  ): Expr[Option[V]] = ...
```

> Finds the minimum value in a column

```scala
def minByOpt[V: TypeMapper](f: T => Expr[V])(
      implicit qr: Queryable.Row[Expr[V], V]
  ): Expr[Option[V]] = ...
```

> Finds the maximum value in a column

```scala
def maxByOpt[V: TypeMapper](f: T => Expr[V])(
      implicit qr: Queryable.Row[Expr[V], V]
  ): Expr[Option[V]] = ...
```

> Computes the average value of a column

```scala
def avgByOpt[V: TypeMapper](f: T => Expr[V])(
      implicit qr: Queryable.Row[Expr[V], V]
  ): Expr[Option[V]] = ...
```

> TRUE if any value in a set is TRUE

```scala
def any(f: T => Expr[Boolean]): Expr[Boolean] = ...
```

> TRUE if all values in a set are TRUE

```scala
def all(f: T => Expr[Boolean]): Expr[Boolean] = ...
```

#### `BitwiseFunctionOps.scala`

```scala
trait BitwiseFunctionOps[T] extends scalasql.operations.ExprNumericOps[T]
```

```scala
override def &[V: Numeric](x: Expr[V]): Expr[T] = ...
```

```scala
override def |[V: Numeric](x: Expr[V]): Expr[T] = ...
```

```scala
override def unary_~ : Expr[T] = ...
```

#### `CaseWhen.scala`

```scala
class CaseWhen[T: TypeMapper](values: Seq[(Expr[Boolean], Expr[T])]) extends Expr[T]
```

```scala
def renderToSql0(implicit ctx: Context): SqlStr = ...
```

```scala
def `else`(other: Expr[T]) = ...
```

```scala
object CaseWhen
```

```scala
class Else[T: TypeMapper](values: Seq[(Expr[Boolean], Expr[T])], `else`: Expr[T])
```

```scala
def renderToSql0(implicit ctx: Context): SqlStr = ...
```

#### `ConcatOps.scala`

```scala
trait ConcatOps
```

> Concatenate all arguments. NULL arguments are ignored.

```scala
def concat(values: Expr[?]*): Expr[String] = ...
```

> Concatenate all but first arguments with separators. The first parameter is used
> as a separator. NULL arguments are ignored.

```scala
def concatWs(sep: Expr[String], values: Expr[?]*): Expr[String] = ...
```

#### `DbApiOps.scala`

```scala
class DbApiOps(dialect: DialectTypeMappers)
```

> Creates a SQL `CASE`/`WHEN`/`ELSE` clause

```scala
def caseWhen[T: TypeMapper](values: (Expr[Boolean], Expr[T])*) = ...
```

> The row_number() of the first peer in each group - the rank of the current row
> with gaps. If there is no ORDER BY clause, then all rows are considered peers and
> this function always returns 1.

```scala
def rank(): Expr[Int] = ...
```

> The number of the row within the current partition. Rows are numbered starting
> from 1 in the order defined by the ORDER BY clause in the window definition, or
> in arbitrary order otherwise.

```scala
def rowNumber(): Expr[Int] = ...
```

> The number of the current row's peer group within its partition - the rank of the
> current row without gaps. Rows are numbered starting from 1 in the order defined
> by the ORDER BY clause in the window definition. If there is no ORDER BY clause,
> then all rows are considered peers and this function always returns 1.

```scala
def denseRank(): Expr[Int] = ...
```

> Despite the name, this function always returns a value between 0.0 and 1.0 equal to
> (rank - 1)/(partition-rows - 1), where rank is the value returned by built-in window
> function rank() and partition-rows is the total number of rows in the partition. If
> the partition contains only one row, this function returns 0.0.

```scala
def percentRank(): Expr[Double] = ...
```

> The cumulative distribution. Calculated as row-number/partition-rows, where row-number
> is the value returned by row_number() for the last peer in the group and partition-rows
> the number of rows in the partition.

```scala
def cumeDist(): Expr[Double] = ...
```

> Argument N is handled as an integer. This function divides the partition into N groups
> as evenly as possible and assigns an integer between 1 and N to each group, in the order
> defined by the ORDER BY clause, or in arbitrary order otherwise. If necessary, larger
> groups occur first. This function returns the integer value assigned to the group that
> the current row is a part of.

```scala
def ntile(n: Int): Expr[Int] = ...
```

> The lag() function returns the result of evaluating expression expr against the
> previous row in the partition. Or, if there is no previous row (because the current
> row is the first), NULL.
>
> If the offset argument is provided, then it must be a non-negative integer. In this
> case the value returned is the result of evaluating expr against the row offset rows
> before the current row within the partition. If offset is 0, then expr is evaluated
> against the current row. If there is no row offset rows before the current row, NULL
> is returned.
>
> If default is also provided, then it is returned instead of NULL if the row identified
> by offset does not exist.

```scala
def lag[T](e: Expr[T], offset: Int = -1, default: Expr[T] = null): Expr[T] = ...
```

> The lead() function returns the result of evaluating expression expr against the next
> row in the partition. Or, if there is no next row (because the current row is the last),
> NULL.
>
> If the offset argument is provided, then it must be a non-negative integer. In this
> case the value returned is the result of evaluating expr against the row offset rows
> after the current row within the partition. If offset is 0, then expr is evaluated
> against the current row. If there is no row offset rows after the current row, NULL
> is returned.
>
> If default is also provided, then it is returned instead of NULL if the row identified
> by offset does not exist.

```scala
def lead[T](e: Expr[T], offset: Int = -1, default: Expr[T] = null): Expr[T] = ...
```

> Calculates the window frame for each row in the same way as an aggregate window
> function. It returns the value of expr evaluated against the first row in the window
> frame for each row.

```scala
def firstValue[T](e: Expr[T]): Expr[T] = ...
```

> Calculates the window frame for each row in the same way as an aggregate window
> function. It returns the value of expr evaluated against the last row in the window
> frame for each row.

```scala
def lastValue[T](e: Expr[T]): Expr[T] = ...
```

> Calculates the window frame for each row in the same way as an aggregate window
> function. It returns the value of expr evaluated against the row N of the window
> frame. Rows are numbered within the window frame starting from 1 in the order
> defined by the ORDER BY clause if one is present, or in arbitrary order otherwise.
> If there is no Nth row in the partition, then NULL is returned.

```scala
def nthValue[T](e: Expr[T], n: Int): Expr[T] = ...
```

#### `ExprAggOps.scala`

```scala
abstract class ExprAggOps[T](v: Aggregatable[Expr[T]])
```

> Concatenates the given values into one string using the given separator

```scala
def mkString(sep: Expr[String] = null)(implicit tm: TypeMapper[T]): Expr[String]
```

#### `ExprBooleanOps.scala`

```scala
class ExprBooleanOps(v: Expr[Boolean])
```

> TRUE if both Boolean expressions are TRUE

```scala
def &&(x: Expr[Boolean]): Expr[Boolean] = ...
```

> TRUE if either Boolean expression is TRUE

```scala
def ||(x: Expr[Boolean]): Expr[Boolean] = ...
```

> Reverses the value of any other Boolean operator

```scala
def unary_! : Expr[Boolean] = ...
```

#### `ExprNumericOps.scala`

```scala
class ExprNumericOps[T: Numeric](v: Expr[T])(implicit val m: TypeMapper[T])
```

> Addition

```scala
def +[V: Numeric](x: Expr[V]): Expr[T] = ...
```

> Subtraction

```scala
def -[V: Numeric](x: Expr[V]): Expr[T] = ...
```

> Multiplication

```scala
def *[V: Numeric](x: Expr[V]): Expr[T] = ...
```

> Division

```scala
def /[V: Numeric](x: Expr[V]): Expr[T] = ...
```

> Remainder

```scala
def %[V: Numeric](x: Expr[V]): Expr[T] = ...
```

> Bitwise AND

```scala
def &[V: Numeric](x: Expr[V]): Expr[T] = ...
```

> Bitwise OR

```scala
def |[V: Numeric](x: Expr[V]): Expr[T] = ...
```

> Bitwise XOR

```scala
def ^[V: Numeric](x: Expr[V]): Expr[T] = ...
```

> TRUE if the operand is within a range

```scala
def between(x: Expr[Int], y: Expr[Int]): Expr[Boolean] = ...
```

> Unary Positive Operator

```scala
def unary_+ : Expr[T] = ...
```

> Unary Negation Operator

```scala
def unary_- : Expr[T] = ...
```

> Unary Bitwise NOT Operator

```scala
def unary_~ : Expr[T] = ...
```

> Returns the absolute value of a number.

```scala
def abs: Expr[T] = ...
```

> Returns the remainder of one number divided into another.

```scala
def mod[V: Numeric](x: Expr[V]): Expr[T] = ...
```

> Rounds a noninteger value upwards to the next greatest integer. Returns an integer value unchanged.

```scala
def ceil: Expr[T] = ...
```

> Rounds a noninteger value downwards to the next least integer. Returns an integer value unchanged.

```scala
def floor: Expr[T] = ...
```

> The sign(X) function returns -1, 0, or +1 if the argument X is a numeric
> value that is negative, zero, or positive, respectively. If the argument to sign(X)
> is NULL or is a string or blob that cannot be losslessly converted into a number,
> then sign(X) returns NULL.

```scala
def sign: Expr[T] = ...
```

#### `ExprOps.scala`

```scala
class ExprOps[A](v: Expr[A])
```

> SQL-style Equals to, translates to SQL `=`. Returns `false` if both values are `NULL`

```scala
def ` = ...
```

> SQL-style Not equals to, translates to SQL `<>`. Returns `false` if both values are `NULL`

```scala
def <>[V](x: Expr[V])(using TypeEq[A, V]): Expr[Boolean] = ...
```

> Greater than

```scala
def >[V](x: Expr[V])(using TypeEq[A, V]): Expr[Boolean] = ...
```

> Less than

```scala
def <[V](x: Expr[V])(using TypeEq[A, V]): Expr[Boolean] = Expr { implicit ctx =>
    sql"($v < $x)"
```

> Greater than or equal to

```scala
def > = ...
```

> Less than or equal to

```scala
def <=[V](x: Expr[V])(using TypeEq[A, V]): Expr[Boolean] = Expr { implicit ctx =>
    sql"($v <= $x)"
```

> Translates to a SQL `CAST` from one type to another

```scala
def cast[V: TypeMapper]: Expr[V] = ...
```

> Similar to [[cast]], but allows you to pass in an explicit [[SqlStr]] to
> further specify the SQL type you want to cast to

```scala
def castNamed[V: TypeMapper](typeName: SqlStr): Expr[V] = ...
```

#### `ExprOptionOps.scala`

```scala
class ExprOptionOps[T: TypeMapper](v: Expr[Option[T]])(implicit dialect: DialectTypeMappers)
```

```scala
def isDefined: Expr[Boolean] = ...
```

```scala
def isEmpty: Expr[Boolean] = ...
```

```scala
def map[V: TypeMapper](f: Expr[T] => Expr[V]): Expr[Option[V]] = ...
```

```scala
def flatMap[V: TypeMapper](f: Expr[T] => Expr[Option[V]]): Expr[Option[V]] = ...
```

```scala
def get: Expr[T] = ...
```

```scala
def getOrElse(other: Expr[T]): Expr[T] = ...
```

```scala
def orElse(other: Expr[Option[T]]): Expr[Option[T]] = ...
```

```scala
def filter(other: Expr[T] => Expr[Boolean]): Expr[Option[T]] = ...
```

#### `ExprStringLikeOps.scala`

```scala
abstract class ExprStringLikeOps[T](v: Expr[T])
```

> Concatenates two strings

```scala
def +(x: Expr[T]): Expr[T] = ...
```

> TRUE if the operand matches a pattern

```scala
def like(x: Expr[T]): Expr[Boolean] = ...
```

> Returns an integer value representing the starting position of a string within the search string.

```scala
def indexOf(x: Expr[T]): Expr[Int]
```

> Converts a string to all lowercase characters.

```scala
def toLowerCase: Expr[T] = ...
```

> Converts a string to all uppercase characters.

```scala
def toUpperCase: Expr[T] = ...
```

> Returns the number of characters in this string

```scala
def length: Expr[Int] = ...
```

> Returns the number of bytes in this string

```scala
def octetLength: Expr[Int] = ...
```

> Returns a portion of a string.

```scala
def substring(start: Expr[Int], length: Expr[Int]): Expr[T] = ...
```

> Returns whether or not this strings starts with the other.

```scala
def startsWith(other: Expr[T]): Expr[Boolean] = ...
```

> Returns whether or not this strings ends with the other.

```scala
def endsWith(other: Expr[T]): Expr[Boolean] = ...
```

> Returns whether or not this strings contains the other.

```scala
def contains(other: Expr[T]): Expr[Boolean] = ...
```

#### `ExprStringOps.scala`

```scala
trait ExprStringOps[T]
```

> Removes leading and trailing whitespace characters from a character string.

```scala
def trim: Expr[T] = ...
```

> Removes leading whitespace characters from a character string.

```scala
def ltrim: Expr[T] = ...
```

> Removes trailing whitespace characters from a character string.

```scala
def rtrim: Expr[T] = ...
```

> The replace(X,Y,Z) function returns a string formed by substituting string Z
> for every occurrence of string Y in string X

```scala
def replace(y: Expr[T], z: Expr[T]): Expr[T] = ...
```

#### `ExprTypedOps.scala`

```scala
class ExprTypedOps[T: ClassTag](v: Expr[T])
```

> Scala-style Equals to, returns `true` if both values are `NULL`.
> Translates to `IS NOT DISTINCT FROM` if both values are nullable,
> otherwise translates to `=`

```scala
def = ...
```

> Scala-style Not equals to, returns `false` if both values are `NULL`
> Translates to `IS DISTINCT FROM` if both values are nullable,
> otherwise translates to `<>`

```scala
def ! = ...
```

#### `HyperbolicMathOps.scala`

```scala
trait HyperbolicMathOps
```

> Calculate the hyperbolic sine

```scala
def sinh[T: Numeric](v: Expr[T]): Expr[T] = ...
```

> Calculate the hyperbolic cosine

```scala
def cosh[T: Numeric](v: Expr[T]): Expr[T] = ...
```

> Calculate the hyperbolic tangent

```scala
def tanh[T: Numeric](v: Expr[T]): Expr[T] = ...
```

#### `MathOps.scala`

```scala
trait MathOps
```

> Converts radians to degrees

```scala
def degrees[T: Numeric](x: Expr[T]): Expr[Double] = ...
```

> Converts degrees to radians

```scala
def radians[T: Numeric](x: Expr[T]): Expr[Double] = ...
```

> `x` raised to the power of `y`

```scala
def power[T: Numeric](x: Expr[T], y: Expr[T]): Expr[Double] = ...
```

> Raises a value to the power of the mathematical constant known as e.

```scala
def exp[T: Numeric](x: Expr[T]): Expr[Double] = ...
```

> Returns the natural logarithm of a number.

```scala
def ln[T: Numeric](v: Expr[T]): Expr[Double] = ...
```

> Logarithm of x to base b

```scala
def log[T: Numeric](b: Expr[Int], x: Expr[T]): Expr[Double] = ...
```

> Base 10 logarithm

```scala
def log10[T: Numeric](x: Expr[T]): Expr[Double] = ...
```

> Computes the square root of a number.

```scala
def sqrt[T: Numeric](v: Expr[T]): Expr[Double] = ...
```

> Calculate the trigonometric sine

```scala
def sin[T: Numeric](v: Expr[T]): Expr[Double] = ...
```

> Calculate the trigonometric cosine

```scala
def cos[T: Numeric](v: Expr[T]): Expr[Double] = ...
```

> Calculate the trigonometric tangent

```scala
def tan[T: Numeric](v: Expr[T]): Expr[Double] = ...
```

> Calculate the arc sine

```scala
def asin[T: Numeric](v: Expr[T]): Expr[Double] = ...
```

> Calculate the arc cosine

```scala
def acos[T: Numeric](v: Expr[T]): Expr[Double] = ...
```

> Calculate the arc tangent

```scala
def atan[T: Numeric](v: Expr[T]): Expr[Double] = ...
```

> Calculate the arc tangent

```scala
def atan2[T: Numeric](v: Expr[T], y: Expr[T]): Expr[Double] = ...
```

> Returns the value of Pi

```scala
def pi: Expr[Double] = ...
```

#### `PadOps.scala`

```scala
trait PadOps
```

```scala
def rpad(length: Expr[Int], fill: Expr[String]): Expr[String] = ...
```

```scala
def lpad(length: Expr[Int], fill: Expr[String]): Expr[String] = ...
```

#### `TrimOps.scala`

```scala
trait TrimOps
```

> Trim [[x]]s from the left hand side of the string [[v]]

```scala
def ltrim(x: Expr[String]): Expr[String] = ...
```

> Trim [[x]]s from the right hand side of the string [[v]]

```scala
def rtrim(x: Expr[String]): Expr[String] = ...
```

#### `TypeEq.scala`

> TypeEq indicates that values of two given types can be compared with each other.

```scala
trait TypeEq[A, B]
```

```scala
object TypeEq extends LowLevelDeprecated
```

```scala
given [A, B](using A =:= B): TypeEq[A, B] = ...
```

```scala
trait LowLevelDeprecated
```

```scala
given [A, B](using A =:= B): TypeEq[Option[A], B] = ...
```

```scala
given [A, B](using A =:= B): TypeEq[A, Option[B]] = ...
```

```scala
given [A, B]: TypeEq[A, B] = ...
```

```scala
trait unsafeEq
```

```scala
given [A, B]: TypeEq[A, B] = ...
```

```scala
given [A, B](using A =:= B): TypeEq[A, Option[B]] = ...
```

```scala
given [A, B](using A =:= B): TypeEq[Option[A], B] = ...
```

```scala
object unsafeEq extends unsafeEq
```

