use "ponytest"
use "collections"
use "../mocks"

//// BEGIN PSUDO-GENERATED CODE ////

// Given an actor or class to stub:
// for each public (constructor | function | behaviour) as item
//   generate private field: '_calls_${item.name}' as an array of ArgumentsN
//   generate private field: '_stub_${item.name}' as an array of item.return_type
//   generate stub/mock with $item.signature
//   generate stubbing/mocking functions if the item is a class
//   generate stubbing/mocking behaviours if the item is an actor
//   generate accessors as functions if the item is a class
//   generate accessors with callbacks if the item is an actor


actor StubCutDownTCPConnection is CutDownTCPConnection
    let _calls_create: Array[Arguments2[String, String]] = Array[Arguments2[String, String]]
    let _calls_write: Array[Arguments1[Array[U8] val] val] = Array[Arguments1[Array[U8] val] val]
    let _calls_access: Array[Arguments0] = Array[Arguments0]
    let _stub_access_idx: USize = 0
    let _stub_access: Array[U32] = Array[U32]

    // STUBS / MOCKS
    new create(host: String, service: String) =>
        _calls_create.push(Arguments2[String, String](host, service))
    be write(data: Array[U8] val) =>
        _calls_write.push(recover val Arguments1[Array[U8] val](data) end)
    fun ref access(): U32 =>
        _calls_access.push(Arguments0)
        try
            if _stub_access_idx < _stub_access.size() then
                _stub_access.apply(_stub_access_idx)?
            else
                _stub_access.apply(_stub_access.size()-1)?
            end
        else 0 end

    // STUBBING/MOCKING behaviours.
    be add_responses_access(response: U32) =>
        _stub_access.push(response)  

    // callback for use in assertions.
    be with_calls_write(cb: {(Array[Arguments1[Array[U8] val] val])} iso) =>
        let c: Array[Arguments1[Array[U8] val] val] iso = recover iso Array[Arguments1[Array[U8] val] val] end
        for args in _calls_write.values() do
            c.push(args)
        end
        cb(consume c)

//// BEGIN TEST CODE ////

primitive SomethingTest is TestWrapped
	fun all_tests(): Array[UnitTest iso] =>
		[as UnitTest iso:

object iso is UnitTest
	fun name(): String => ""
	fun apply(h: TestHelper) =>
        // SETUP
        let conn: StubCutDownTCPConnection = StubCutDownTCPConnection("a", "b")
        let thing_to_test = ThingToTest
        h.expect_action("foo")
        h.long_test(1_000_000_000)

        // CALL UNDER TEST
        thing_to_test.connected(conn) // on 'connect', the TCPConnectionHandler immediately writes 'foo'.

        // ASSERT
        conn.with_calls_write(recover iso {
            (args: Array[Arguments1[Array[U8] val] val])(h) =>
                if args.size() >= 1 then
                    try h.complete_action(String.from_array(args.apply(0)?.a)) end
                end
        } end)
end

]


// vi: sw=4 sts=4 ts=4 noet