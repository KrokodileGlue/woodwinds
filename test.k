fn f (x) = x * 2

var a = 'foo' + 'bar' + ((2 + 4) * 3 / 9 - 1 + 4)
pl a

var b = 2 * 2
pl (b + 6) + a
b = 2000

pl '2 * 2 = ', f(2)

fn g = 'stuff'
pl g()

var c = [1, 2, 3, 4]
pl c
c[0][5] = 0
c[0][4] = 1
c[50][0] = 2
pl c

var d = 0
fn h = d++

for var i = 0; i < 30; i++:
	pl h()

p 'checking if g() == "stuff"... '

if g() == 'stuff':
	pl '[TRUE]'
else
	pl '[FALSE]'

fn fib (x) {
	if x < 2: return x
	return fib(x - 1) + fib(x - 2)
}

for var i = 0; i < 20; i++:
	pl i, ': ', fib(i)

pl type a
pl type b
pl type c
pl type d

var dim = 50

fn square (dim) {
	var field = []

	for var y = 0; y < dim; y++:
		for var x = 0; x < dim; x++ {
			field[x][y] = ' '
			if y == x or y == dim - x:
				 field[x][y] = '#'
		}

	for var y = 0; y < dim; y++ {
		for var x = 0; x < dim; x++:
			p field[x][y]
		p '\n'
	}
}

fn ppm-square (dim) {
	pl 'P3'
	pl dim, ' ', dim
	pl dim

	for var y = 0; y < dim; y++:
		for var x = 0; x < dim; x++:
	 		p x + ' ' + y + ' 0 '

	p '\n'
}

square(dim)
# ppm-square(dim)

fn t (x) pl type x

t('this'), t('that'), t(2), t(true), t([1, 2, 'stuff']), t(1.2)

var n = 0
while n < 10: pl n++
n = 0
do pl n++; while n < 10

pl 'stuff: ', 3 * 3.1415926535897932

var array = [1, 2, 3, 4]

fn function (x) {
	x[0] = 'asdf'
	pl x
}

pl array
function(array)
pl array
pl length array
array[0] = ['abc', 'def', [0, 1, 2]]

for var i = 0; i < length array; i++:
	pl i + ': ' + array[i]

# fn join (x y) {
# 	return y when type y != 'array'
# 	var r
# 	for var i = 0; i < length y - 1; i++:
# 		r += y[i] + x
# 	return r + y[length y - 1]
# }

fn djoin (x, y) {
	return y when type y != 'array'
	var r = ''

	for var i = 0; i < length y - 1; i++ {
		if type y[i] == 'array': r += djoin(x, y[i]) + x
		else r += y[i] + x
	}

	return r + djoin(x, y[length y - 1])
}

pl join ', ', array
pl djoin(', ', array)

var it = [fn { pl type array }, 2, 3, 4]
it[0]()
pl it[1] + it[-500]

for var i = 0; i < 40; i++ {
	next when i %% 2
	pl i
	last when i == 19
}

fn scope {
	var hard-normal-daddy = 300

	fn internal (x) {
		p type x
		# error: undeclared identifier
		# pl hard-normal-daddy
	}

	pl 'this should say array: ', internal([])
}

scope()

# fn range(x y) {
# 	var ret
# 	for var i = 0; i <= y - x; i++:
# 		ret[i] = i + x
# 	return ret
# }

{
	for var i; range(5, 9): pl i

	pl '========'

	var i
	for i; range(5, 9): pl i

	pl '========'

	for range(5, 9): pl _

	pl '========'

	pl join(', ', map { 2 ** _ } range(0, 62))
}

pl join('-', split / /, 'this is something')

var string = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur dictum.'

# for string =~ /\w+/: pl _
for string =~ /\w+/: ;
pl join(':', string =~ /\w+/g)
pl join(':', split //, string)

if string =~ /^(.*?), (.*)$/:
	pl 'group 1: "' + $1 + '", group 2: "' + $2 + '"'

pl string =~ s/[aeiouy]+/\U$0/gi
pl eval "string =~ s/[aeiouy]+//gi"

pl join(', ', map { 2 ** _ } range(0, 12))
pl eval "join(', ', map { 2 ** _ } range(0, 12))"
eval "pl 'test'"

fn test-eval {
	eval "return join(':', split / /, 'this is test-eval returning.')"
}

pl test-eval(), ' ', test-eval()

for var i = 0; i < 10; i++ {
	eval "if i %% 2: next"
	pl i

	for var j = 0; j < 10; j++ {
		pl 'j: ', j
		eval "if j == 5: last"
	}

	eval "if i == 7 { last }"
}

# eval "next"

string = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur dictum.'
pl string =~ s/[aeiouy]+/"'o'"/eegi

string = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur dictum.'
pl string =~ s/(\w)(\w+)/uc $1 + join('-', split ~~, $2)/egi

eval 'var __ = "this is an eval-scoped variable."; pl __'

# error: undeclared identifier
# eval 'pl __'

pl join(' ', map { reverse } split / /, 'this is test')
pl join(' ', map { ucfirst reverse } 'this is test' =~ /\w+/g)
pl join(' ', map { lc reverse } 'tHiS iS tEst' =~ /\w+/g)
pl reverse 'this is test'

pl join ', ', reverse range(0, 30)
pl join('\n', map { reverse join('-', split //) } ['foo', 'bar'])

pl join(':', map { sayln } range(0, 5))

var table = {
	a = 'some text',
	b = fn (self, x) {
		self.a = x
	},
	uninitialized-field
}

pl table['a']
table['b'](table, 5555)

pl table.a
table.b(1000)
pl table.a

if !table.uninitialized-field:
	pl 'table.uninitialized-field is nil.'

fn Boat (name = 'U.S.S. Nameless', attack = 20) = {
	name = name,
	health = 100,
	alive = true,
	attack = attack,

	x = 0,
	y = 0,
	z = 0,

	move = fn (self, x, y, z) {
		self.x += x
		self.y += y
		self.z += z
	},

	show = fn (self) {
		pl 'The ', self.name, ' is at '
		    + self.x + ', ' + self.y + ', ' + self.z + '.'
	},

	damage = fn (self, damage) {
		self.health = self.health - damage
		pl 'The ', self.name, ' takes ',        damage, ' damage!'
		pl 'The ', self.name, ' now has ', self.health, ' health.'

		self.alive = (self.health > 0)
	},

	is-alive = fn (self) {
		self.alive = (self.health > 0)
		pl self.alive ? 'The ' + self.name + ' is still kicking.'
			      : 'The ' + self.name + ' is dead! RIP!'
	},

	fight = fn (self, enemy) {
		pl 'The ', self.name, ' is now fighting the ', enemy.name, '!'

		if enemy.alive {
			pl 'The ', enemy.name, ' deals ', enemy.attack, ' damage!'
			self.damage(enemy.attack)
		} else pl 'The ', enemy.name, ' cannot fight because it is dead.'

		if self.alive and !enemy.alive {
			pl 'The ', self.name, ' is victorious.'
		} else self.is-alive()
	}
}

var boat1 = Boat('U.S.S. Enterprise', 25)
pl boat1.name
var boat2 = Boat('S.S. Minnow', 30)
pl boat2.name
var boat3 = Boat()
boat2.fight(boat3)

boat1.show()
boat1.move(0, 1, 0)
boat1.move(3, -30, 7)
boat1.show()

while boat1.alive and boat2.alive {
	boat1.fight(boat2)
	boat2.fight(boat1)
}

pl join ', ', range 0, 24.5, 5
pl join ', ', range 0.1, 24.5, 5
pl join ', ', range 0, 24.5, 5

var arr = [1, 2, 3, 4]
arr[3] += 10
arr[3] -= 4
pl arr[3]

boat2.is-alive()
boat2.health -= 100
boat2.is-alive()

var _str = 'string subscripts?'

if !_str[500] and !_str[-1]:
	pl 'invalid subscripts produce nil.'

pl map { _str[] } range 7, 16

var tstr = _str
pl tstr
pl _str[6] = '-'
pl tstr
pl type _str

var asdf = [1, 2, 3, [4, 5, 6]]
var temp = asdf[3]
temp[0] = 500
pl join ', ', asdf;

pl join ', ', push asdf, 7
map { push asdf } range 8, 10
pl join ', ', asdf

pl join ', ', map { (2 *) + } range 1, 5

# error: string requires integer subscript (got nil)
# pl _str[]

pl 5 * 'test'
pl join ', ', 5 * ['foo', 'bar']

pl int '-0x100' * 2
pl float '3.1415926535897932' * 3
pl str(400) * 2

var x
pl join ', ', [0 for range 0, 9]
pl join ', ', [2 * x for x in range 0, 9]
pl join ', ', [3 * y for var y in range 0, 9]
pl join ', ', [2 * for [2 * for range 0, 9]]

fn arg1 (a, b, c, d = 3) {
	pl d
}

arg1(1, 2, 3)
arg1(1, 2, 3, 'd')

fn arg2 (a, b, c, d = ...) {
	pl '====== argtest ======'

	pl a, ' (', type (a), ')'
	pl b, ' (', type (b), ')'
	pl c, ' (', type (c), ')'
	pl join (', ', d), ' (', type (d), ')'
}

arg2(1, 2, 3)
arg2(1, 2, 3, 4, 5, 6, 7)
arg2(1)

pl string

string =~ s/-//g
string = ucfirst lc string
string =~ s/(?<=\.\s+)(\w)/\u$1/

pl string
pl match string {
	/asdf/ => 'asdf!',

	/(.*?)amet/ => {
		pl 'Statement!'
		'thing: ' + $1
	},

	// => +{
		foo = 'this is a table!',
		bar = 'tables can be returned from matches.'
	},

	true => 'Goodbye, world!',
	true => 'Hello, world!'
}

pl join ', ', sort [5, 0, -21, 74, -5, 745, 4, -6, 2, 5, -13, 3, 45, -736, 1, 35, -23, 42, 3, 46]

var step = 0
test: step++;

[match _ { 2 => { goto test when step <= 1000 } } for [1, 2, 3]]
pl 'Hello, world!'
if step == 1003: goto end
else goto test

end: pl 'Goodbye, world!'

pl 1 << 2
pl 1 << 16
pl 2 >> 1
pl ((1 << 16) >> 1) & (1 << 15)

fn pa (x) = sayln '[', join(', ', x), ']'

pa((0 -> 10)[4:10:2])
pa((0 -> 10)[::2])
pa((0 -> 10)[::-1])
pa((0 -> 10)[0:5:-1])
pa((0 -> 10)[5:0:-1])
pa((0 -> 10)[0:5])
pa((0 -> 10)[0:10 * 3 + 1])
pa((0 -> 10)[5:])
pa((0 -> 10)[5:0])

for 'a1 b2 c3' =~ /\w(\d)/:
	pl '> ', $1

for 'a4 b5 c6' =~ /\w(\d)/ {
	pl '> ', $1
	/oesfijosfeiefsjoi/
}

for ['a1 b2 c3', 'a4 b5 c6', 'a7 b8 c9', 'a10 b11 c12']:
	for /\w(\d+)/: pl '> $1 and {2 * 5}'

var thing = [1, 2, 3, 4]
pl ++thing[0]
pl ++thing[0]
pl --thing[0]
pl --thing[0]

pl chr(72, 101, 108, 108, 111, 44, 32, 119, 111, 114, 108, 100, 33)
pl chr([72, 101, 108, 108, 111, 44, 32, 119, 111, 114, 108, 100, 33])
pl chr(104)

pl join ', ', ord('Hello, world!')
pl join ', ', ord(['Hello,', ' world!'])
pl join ', ', ord('H', 'e', 'l', 'l', 'o', ',', ' ', 'w', 'o', 'r', 'l', 'd', '!')

import 'foo.k' as foo
import 'mandel.k'

pl foo::foo(4, 25)
pl foo::bar(4, 25)

pl '{{}}}}{{{array}'

for ['a1 b2 c3', 'a4 b5 c6', 'a7 b8 c9', 'a10 b11 c12']:
	for var j; /\w(\d+)/: pl '> $1 - $j'

# mandel::mandel(1024, 780, 150)

enum FOO = 5 + 5, BAR, BAZ
pl '$FOO, $BAR, $BAZ'

pl join ', ', range(8, 1, -1)

# eval "pl qwerty * 2"
# var qwerty

pl rjust('test', 10)
pl rjust(5, 10)
pl rjust('test', 2)

pl min(0, 1, 2, 3, -1, 4, 5, 6)
pl min([0, 1, 2, 3, -1, 4, 5, 6])

var ejflioeshnfj = 0 -> 10
push ejflioeshnfj, 11

pl join ', ', ejflioeshnfj
pop ejflioeshnfj
pl join ', ', ejflioeshnfj
pop ejflioeshnfj
pl join ', ', ejflioeshnfj
pop ejflioeshnfj

pl pop([]) == nil

pl (+)(0 -> 9)
pl (0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9)

pl (-)(0 -> 9)
pl (0 - 1 - 2 - 3 - 4 - 5 - 6 - 7 - 8 - 9)

pl (|)(0 -> 9)
pl (0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9)

fn main (x = ...) for 0 -> x: pl 'arg $_: ', x[]

# TODO: fix the api design
# TODO: standard library -- i/o
# TODO: fully lexical scope (nested functions)
# TODO: actually implement the tracing garbage collector
# TODO: regex matches shouldn't survive function calls
# TODO: sort should care about arrays with mixed types
# TODO: lvalue array slices
# TODO: finish the constant expression compiler
# TODO: look at how while loops handle regex
# TODO: fix eval and that stack trace bug
# TODO: bindings and ffi
# TODO: json parser (in an actual module, but in C)
# TODO: add delete builtin
# TODO: allow _ in numbers and remove all use of strtol
# TODO: free eval'd modules quickly -- bitmap allocator
# TODO: allow trailing commas in places
# TODO: fix failed assertion when using a nonexistent
#       variable in a string interpolation
# TODO: fix the error message doubling problem, e.g.:
# 	var qwerty; # and why is this semicolon necessary?
# 	eval "pl qwerty * 2"
# TODO: for some reason these two lines are not equal:
#       if foo: for f(x): if bar[_] == foo { return _ }
#       if foo: for f(x): if bar[_] == foo: return _
# TODO: ternary operator should behave cool-ly
# TODO: add `if` to list comprehensions
# TODO: operator overloading/constructors
# TODO: `in` operator
# TODO: module modes
# TODO: make the interpreter installation rule link against the
#       installed library
# TODO: repl
# TODO: for some reason
#       'string' => str(n.body =~ /[^\"]+/),
#       works as intended, but
#       'string' => n.body[1:-1],
#       does not (it's important that the context is a
#       match expression i think).
# TODO: make int builtin convert floats to ints
