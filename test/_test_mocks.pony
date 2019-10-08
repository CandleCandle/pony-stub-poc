use "ponytest"
use "collections"
use "../mocks"

primitive Arguments0
    new create() => None

class Arguments1[A: Any #read]
    let _a: A
    new create(a: A) =>
        _a = a

class Arguments2[A: Any #read, B: Any #read]
    let _a: A
    let _b: B
    new create(a: A, b: B) =>
        _a = a
        _b = b

type _CreateArguments is Arguments2[String, String]
type _WriteArguments is Arguments1[Array[U8] val]

actor StubCutDownTCPConnection is CutDownTCPConnection
    let _calls_create: Array[_CreateArguments] = Array[_CreateArguments]
//    let _responses_create: Map[_CreateArguments, Array[None]] = Map[_CreateArguments, Array[None]]
    let _calls_write: Array[_WriteArguments] = Array[_WriteArguments]
//    let _responses_create: Map[_WriteArguments, Array[None]] = Map[_WriteArguments, Array[None]]
    let _calls_access: Array[Arguments0] = Array[Arguments0]
    let _responses_access_call: USize = 0
    let _responses_access: Array[U32] = Array[U32]

    new create(host: String, service: String) =>
        _calls_create.push( Arguments2[String, String](host, service) )
    be write(data: Array[U8] val) =>
        _calls_write.push( Arguments1[Array[U8] val](data) )
    fun ref access(): U32 =>
        try
            if _responses_access_call < _responses_access.size() then
                _responses_access.apply(_responses_access_call)?
            else
                _responses_access.apply(_responses_access.size()-1)?
            end
        else 0 end

primitive SomethingTest is TestWrapped
	fun all_tests(): Array[UnitTest iso] =>
		[as UnitTest iso:

object iso is UnitTest
	fun name(): String => ""
	fun apply(h: TestHelper) =>

		let undertest = None
		// h.assert_eq[String](undertest, None)
end

]


// vi: sw=4 sts=4 ts=4 noet