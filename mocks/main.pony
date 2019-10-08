

interface tag CutDownTCPConnection
    new tag create(host: String, service: String)
    be write(data: Array[U8] val)
    fun ref access(): U32

interface CutDownTCPConnectionNotify
    fun ref connected(conn: CutDownTCPConnection)
    fun ref received(conn: CutDownTCPConnection, data: Array[U8] iso): Bool

class ThingToTest is CutDownTCPConnectionNotify
    fun ref connected(conn: CutDownTCPConnection) =>
        conn.write("foo".array())
    fun ref received(conn: CutDownTCPConnection, data: Array[U8]): Bool =>
        true



// vi: sw=4 sts=4 ts=4 noet