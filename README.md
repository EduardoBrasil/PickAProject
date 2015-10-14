[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Duerno/PickAProject?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![Stories in Ready](https://badge.waffle.io/Duerno/PickAProject.svg?label=ready&title=Ready)](http://waffle.io/Duerno/PickAProject)
<a href="https://codeclimate.com/github/Duerno/PickAProject"><img src="https://codeclimate.com/github/Duerno/PickAProject/badges/gpa.svg" /></a>



# The Pick a Project Development Style Guide

This style guide recommends all the practices to write code and contributing with this project, that can be understood, maintained and shared by other real-world Ruby on Rails programmers. It was based on “Ruby coding style guide”, a community open document that brings together the best coding practices. But realize yourself that some changes have been made to fit well in this project that applies the best technics and good practices researched the last years.
Of course all these practices do not constitute strict rules into the Ruby community, but this project do. Any deviation from these rules will be treated as an error and should be corrected before submit the code to our repository.
The guide is separated into several sections of related rules. They are mostly based on programmers’ experience and community feedback, so, maybe some changes will be made.
This project is being made possible by:

|              Name              | Registration Number |           Email          |
|:------------------------------:|:-------------------:|:------------------------:|
| Eduardo Brasil Martins         |      11/0115104     | brasil.eduardo1@gmail.com |
| Felipe Duerno do Couto Almeida |      11/0116712     | felipeduernoal@gmail.com |
|     Luan Guimarães Lacerda     |      12/0125773     |       luan@live.in       |
|     Gabriel Campos Oliveira    |      13/0111058     |   campos.1122@gmail.com  |

## Table of Contents

1. [Source Code Layout](#1-source-code-layout)  
2. [Syntax](#2-syntax)  
3. [Naming](#3-naming)  
4. [Comments](#4-comments)  
5. [Classes & Modules](#5-classes--modules)  
6. [Exceptions](#6-exceptions)  
7. [Collections](#7-collections)  
8. [Strings](#8-strings)  
9. [Regular Expressions](#9-regular-expressions)  
10. [Percent Literals](#10-percent-literals)  

## 1. Source Code Layout

1.1. Use `UTF-8` as the source file encoding.  
1.2. All levels and inside blocks, functions and methods should be correctly identated.  

  ```Ruby
	#	Wrong way.
	class Project
	@@projects_counter = 0
	def initialize(name, level)
	@name = name
	@level = level
	end
	end

	# Wrong way.
	3.times do
		puts "Congractulations! You won three Gama Golds."
		end

	# Wrong way.
	if user_file.respond_to?(:read)
		text_on_user_file = "" + user_file.readlines
		if text_on_user_file == ""
				raise "The user file is empty!"
			end
			end

	# Correct way.
	class Project
		@@projects_counter = 0
	
		def initialize(name, level)
			@name = name
			@level = level
		end
	end

	# Correct way.
	if user_file.respond_to?(:read)
		text_on_user_file = "" + user_file.readlines
		if text_on_user_file == ""
			raise "The user file is empty!"
		end
	end
  ```
  
1.3. Use **only two spaces** per indentation level.

  ```Ruby
  # Wrong way - 4 spaces (hard tab).
  def send_message(text, destination)
      message = Message.new(@user_name, text)

			mailer = Mailer.new
			mailer.send(message, destination)
  end

  # Correct way - 2 spaces (soft tab)
  def send_message(text, destination)
    message = Message.new(@user_name, text)
		mailer = Mailer.new
		mailer.send(message, destination)
  end
  ```

1.4. Configure Unix-style line endings. BSD/Solaris/Linux/OS X users are covered by default, but Windows users have to be careful. Please, before push your commits, protect your code from Windows line endings creeping in:

  ```bash
  $ git config --global core.autocrlf true
  ```

1.5. Do not use `;` to separate statements and expressions. As a
  corollary - use one expression per line.

  ```Ruby
  # Wrong way, superfluous semicolon.
  puts 'Gama Golds are an brilliant idea';

	# Wrong way, two expressions on the same line.
  print 'Gama Golds'; puts ' are an brilliant idea';

  # Here are some correct examples
  puts 'Gama Golds are an brilliant idea'

  puts 'Pick'
  puts 'a'
	puts 'Project'

  puts 'Pick', ' a Project'
  ```

1.6. Prefer a single-line class constructor format for class definitions with no body.

  ```Ruby
  # Wrong way.
  class ProjectCreationError < StandardError
  end

  # Wrong way, remember, do not use ';' to separate statements and expressions
  class ProjectCreationError < StandardError; end

  # Correct way.
  ProjectCreationError = Class.new(StandardError)
  ```

1.7. Do not use a single-line method construction

  ```Ruby
  # Wrong ways.
  def write_commentary; something; something_else; end

  def write_commentary; body end

  def write_commentary; body; end

  def write_commentary() body end
	
	# Wrong because makes it kind of hard to read
	def write_commentary()
		# Body.
	end

  # Correct way with no arguments.
  def write_commentary
    # Body.
  end

	# Correct way with one or more arguments.
	def write_commentary (post_id, text)
		# Body.
	end
  ```

1.8. Use spaces around operators, after commas, colons and semicolons, around `{`
  and before `}`. Whitespace might be (mostly) irrelevant to the Ruby
  interpreter, but its proper use is the key to writing easily
  readable code.

  ```Ruby
  sum = 1 + 2
  a, b = 1, 2
  1 > 2 ? true : false; puts 'Hi'
  [1, 2, 3].each { |e| puts e }
  ```

  The only exception, regarding operators, is the exponent operator:

  ```Ruby
  # Wrong way.
  e = M * c ** 2

  # Correct way.
  e = M * c**2
  ```

  `{` and `}` deserve a bit of clarification, since they are used
  for block and hash literals. For hash literals only one styles are considered acceptable.

  ```Ruby
  user = {
		name: nil,
		cell: nil,
		email: nil,
	}
  ```

  String values expressions must be write following the examples:

  ```Ruby
  # Wrong way.
  "string #{value}"

  # Correct way, more readable.
  "string #{ value }"
  ```

1.9. No spaces after `(`, `[` or before `]`, `)`.

  ```Ruby
  some(arg).other
  [1, 2, 3].size
  ```

1.10. No space after `!`.

  ```Ruby
  # Wrong way.
  ! expression

  # Correct way.
  !expression
  ```

1.11. Never indent `when` as deep as `case`. We know that many would disagree
  with this one because it's the style established in both "The Ruby
  Programming Language" and "Programming Ruby", but it makes code more readable.

  ```Ruby
  # Wrong way.
	case
  when project.name == 'Make some money!'
    puts 'Not again!'
  when project.duration > 120
    puts 'Too long!'
  else
    project.publish
  end

	# Correct way.
  case
  	when project.name == 'Make some money!'
    	puts 'Not again!'
  	when project.duration > 120
    	puts 'Too long!'
  	else
    	project.publish
  end
  ```

1.12. Use empty lines between method definitions and also to break up a method
  into logical paragraphs internally.

  ```Ruby
  def write_commentary(post_id, text)
    # Body.
  end

  def delete_commentaty(post_id, commentary_id)
    # Body.
  end
  ```

1.13. Avoid comma after the last parameter in a method call, especially when the
  parameters are not on separate lines.

  ```Ruby
  # Wrong way.
  send_message(
								text, 
								destination,
							)

  # Wrong way.
  send_message(text, destination, )

  # Correct way.
  send_message(text, destination)
  ```

1.14. Use spaces around the `=` operator when assigning default values to method parameters:

  ```Ruby
  # Wrong way.
  def any_method(arg_a=:default, arg_b=nil, arg_c=[])
    # do something...
  end

  # Correct way.
  def any_method(arg_a = :default, arg_b = nil, arg_c = [])
    # do something...
  end
  ```

1.15. Avoid line continuation `\` where not required. In practice, avoid using
  line continuations for anything but string concatenation.

  ```Ruby
  # Wrong way.
  short_string = 'Gama golds' \
								 'are a brilliant idea'
				
	# Correct way.
  long_string = 'Gama golds are a brilliant idea' \
                ', if you don't collaborate, you won't be able to' \
								' ask for some help.'
  ```

1.16. Align the parameters of a method call if they span more than one
  line. When aligning parameters is not appropriate due to line-length
  constraints, single indent for the lines after the first is also
  acceptable.

  ```Ruby
  # Wrong way (line is too long).
  def send_mail(source)
    Mailer.deliver(to: 'bob@example.com', from: 'us@example.com', subject: 'Important message', body: source.text)
  end

  # Wrong way (double indent).
  def send_mail(source)
    Mailer.deliver(
        to: 'bob@example.com',
        from: 'us@example.com',
        subject: 'Important message',
        body: source.text)
  end

  # Correct way
  def send_mail(source)
    Mailer.deliver(to: 'bob@example.com',
                   from: 'us@example.com',
                   subject: 'Important message',
                   body: source.text)
  end

  # Correct way (normal indent)
  def send_mail(source)
    Mailer.deliver(
      to: 'bob@example.com',
      from: 'us@example.com',
      subject: 'Important message',
      body: source.text
    )
  end
  ```

1.17. Align the elements of array literals spanning multiple lines.

  ```Ruby
  # Wrong way (single indent).
  menu_item = ['Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam',
    'New idea', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam']

  # Wrong way.
  menu_item = [
    'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam',
    'New idea', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam'
  ]

  # Correct way.
  menu_item =
    ['Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam',
     'New idea', 'Spam', 'Spam', 'Spam', 'Spam', 'Spam']
  ```

1.18. Add underscores to large numeric literals to improve their readability.

  ```Ruby
  # Wrong way.
  num = 1000000

  # Correct way (more readable).
  num = 1_000_000
  ```

1.19. Limit lines to 80 characters.

1.20. Avoid trailing whitespace.

1.21. End each file with a newline.

1.22. Don't use block comments. They cannot be preceded by whitespace and are not
  as easy to spot as regular comments.

  ```Ruby
  # Wrong way.
  =begin
  comment line
  another comment line
  =end

  # Correct way.
  # comment line
  # another comment line
  ```

## 2. Syntax

2.1. Use `::` only to reference constants(this includes classes and
  modules) and constructors (like `Array()` or `Nokogiri::HTML()`).
  Never use `::` for regular method invocation.

  ```Ruby
  # Wrong way.
  Mailer::send
  message::update_text(new_text)

  # Correct way.
  Mailer.send
  message.update_text
  Message::MAX_SIZE
  SomeModule::SomeClass()
  ```

2.2. Use `def` with parentheses when there are arguments. Omit the
  parentheses when the method doesn't accept any arguments.

   ```Ruby
   # Wrong way.
   def how_many_users()
     # body omitted
   end

   # Correct way.
   def how_many_users
     # body omitted
   end

   # Wrong way.
   def write_commentary post_id, text
     # body omitted
   end

   # Correct way
   def write_commentary (post_id, text)
     # body omitted
   end
   ```

2.3. Never use `for`, unless you know exactly why. Most of the time iterators
  should be used instead. `for` is implemented in terms of `each` (so
  you're adding a level of indirection), but with a twist - `for`
  doesn't introduce a new scope (unlike `each`) and variables defined
  in its block will be visible outside it.

  ```Ruby
  arr = [1, 2, 3]

  # Wrong way.
  for elem in arr do
    puts elem
  end

  # Note that elem is accessible outside of the for loop
  elem # => 3

  # Correct way.
  arr.each { |elem| puts elem }

  # Elem is not accessible outside each's block.
  elem #=> NameError: undefined local variable or method `elem'
  ```

2.4. Never use `then`

  ```Ruby
  # Wrong way.
  if some_condition then
    # Body omitted.
  end

  # Correct way.
  if some_condition
    # Body omitted.
  end
  ```

2.5. Never use `unless` instead of `if !`

2.6. Do not use the ternary operator(`?:`), neither `if/then/else/end` constructs.

  ```Ruby
  # Wrong way.
  result = if some_condition then something else something_else end

  # Wrong way.
  result = some_condition ? something : something_else

  # Correct way.
	if some_condition
		result = something
	else
		result = something_else
  ```

2.7. Use `!` instead of `not`.

  ```Ruby
  # Wrong way
  x = (not y)

  # Correct way
  x = !y
  ```

2.8. Don't use parentheses around the condition of an `if \ while`.

  ```Ruby
  # Wrong way.
  if (x > 10)
    # Body omitted.
  end

  # Correct way.
  if x > 10
    # Body omitted.
  end
  ```

2.9. Omit parentheses around parameters for methods that are part of an
  internal DSL (e.g. Rake, Rails, RSpec), methods that have
  "keyword" status in Ruby (e.g. `attr_reader`, `puts`) and attribute
  access methods. Use parentheses around the arguments of all other
  method invocations.

  ```Ruby
  class Person
    attr_reader :name, :age

    # omitted
  end

  temperance = Person.new('Temperance', 30)
  temperance.name

  puts temperance.age

  x = Math.sin(y)
  array.delete(e)

  bowling.score.should == 0
  ```

2.10. Use `{...}` instead of `do...end`.

  ```Ruby
  names = ['Bozhidar', 'Steve', 'Sarah']

  # Wrong way.
  users.each do |user|
    puts users.name
  end

  # Wrong way.
  users.each { |user| puts users }

  # Wrong way
  names.select do |name|
    name.start_with?('S')
  end.map { |name| name.upcase }

  # Correct way.
  names.select { |name|
		name.start_with?('S') 
	}.map { |name| 
		name.upcase
	}
  ```

2.11. Always use `return`.

  ```Ruby
  # Correct way.
  def some_method(some_arr)
    return some_arr.size
  end

  # Wrong way.
  def some_method(some_arr)
    some_arr.size
  end
  ```

2.12. Use shorthand self assignment operators whenever applicable.

  ```Ruby
  # Wrong way.
  x = x + y
  x = x * y
  x = x**y
  x = x / y
  x = x || y
  x = x && y

  # Correct way.
  x += y
  x *= y
  x **= y
  x /= y
  x ||= y
  x &&= y
  ```

2.13. Use `||=` to initialize variables only if they're not already initialized.

  ```Ruby
  # Wrong way.
  name = name ? name : 'Bozhidar'

  # Wrong way.
  name = 'Bozhidar' unless name

  # Correct way.
  name ||= 'Bozhidar'
  ```

2.14. Don't use `||=` to initialize boolean variables. (Consider what
  would happen if the current value happened to be `false`.)

  ```Ruby
  # bad - would set enabled to true even if it was false
  enabled ||= true

  # good
  enabled = true if enabled.nil?
  ```

2.15. Use `&&=` to preprocess variables that may or may not exist. Using
  `&&=` will change the value only if it exists, removing the need to
  check its existence with `if`.

  ```Ruby
  # Wrong way.
  if !name.nil?
    name.downcase!
  end

  # Wrong way.
  name = name ? nil : name.downcase

  # Wrong way.
  name = name.downcase if name

  # Wrong way.
 	name = name && name.downcase

  # Better way to do this.
  name &&= name.downcase
  ```

2.16. Never put a space between a method name and the opening parenthesis.

  ```Ruby
  # Wrong way.
 	send (user, text)

  # Correct way.
  send(user, text)
  ```

2.17. If the first argument to a method begins with an open parenthesis,
  always use parentheses in the method invocation. For example, write
  `f((3 + 2) + 1)`.

2.18. Always run the Ruby interpreter with the `-w` option so it will warn
  you if you forget either of the rules above!

2.19. Prefer `proc` over `Proc.new`.

  ```Ruby
  # Wrong way.
  p = Proc.new { |n| puts n }

  # Correct way.
  p = proc { |n| puts n }
  ```

2.20. Prefix with `_` unused block parameters and local variables. It's
  also acceptable to use just `_` (although it's a bit less
  descriptive). This convention is recognized by the Ruby interpreter
  and tools like RuboCop and will suppress their unused variable warnings.

  ```Ruby
  # Wrong way.
  shift_post_id = hash.map { |, id| id + 1 }

  # Correct way
  shift_post_id = hash.map { |_post_name, id| id + 1 }
  ```
2.21. Use ranges or `Comparable#between?` instead of complex comparison logic when possible.

  ```Ruby
  # Wrong way.
  x >= 1000 && x <= 2000

  # Correct way.
  (1000..2000).include?(x)

  # Correct way.
  x.between?(1000, 2000)
  ```

## 3. Naming

3.1. Name identifiers in English.

  ```Ruby
  # Wrong way (identifier using non-ascii characters).
  заплата = 1_000

  # Wrong way (identifier is a Portuguese word or a non-english word)
  zaplata = 1_000

  # Correct way.
  gama_golds = 1_000
  ```

3.2. Use camelCase for symbols, methods and variables.

  ```Ruby
  # Wrong way.
  :'gama golds'
  :gamaGolds
  :Gama_Golds

  gamaGolds = 5

  def transferGamaGolds(quantity)
    ...
  end

  def TransferGamaGolds(quantity)
   ...
  end

  # Correct way.
  :gama_golds

  def finalize_a_task(task_id)
    ...
  end
  ```

3.3. Use `CamelCase` for classes and modules.

  ```Ruby
  # Wrong way.
  class Gamagold
    ...
  end

  class Gama_Gold
    ...
  end

  class XmlArchive
    ...
  def

  # Correct way.
  class GamaGold 
    ...
  end

  class XMLArchive
    ...
  end
  ```

3.4. Use `snake_case` for naming files, e.g. `hello_world.rb`.

3.5. Aim to have just a single class/module per source file. Name the file name as
  the class/module, but replacing CamelCase with snake_case.

3.6. Use `SCREAMING_SNAKE_CASE` for other constants.

  ```Ruby
  # Wrong way
  gamaGolds = 5

  # good
  GAMA_GOLDS = 5
  ```

3.7. The names of predicate methods (methods that return a boolean value)
  should end in a question mark.
  (i.e. `Array#empty?`). Methods that don't return a boolean, shouldn't
  end in a question mark.

3.8. The names of potentially *dangerous* methods (i.e. methods that
  modify `self` or the arguments, `exit!` (doesn't run the finalizers
  like `exit` does), etc.) should end with an exclamation mark if
  there exists a safe version of that *dangerous* method.

  ```Ruby
  # Wrong way (there is no matching 'safe' method)
  class Person
    def update!
    end
  end

  # Correct way.
  class Person
    def update
    end
  end

  # Correct way.
  class Person
    def update!
    end

    def update
    end
  end
  ```

3.9. Define the non-bang (safe) method in terms of the bang (dangerous)
  one if possible.

  ```Ruby
  class Array
    def flatten_once!
      res = []

      each do |e|
        [*e].each { |f| res << f }
      end

      replace(res)
    end

    def flatten_once
      dup.flatten_once!
    end
  end
  ```

3.10. When using `reduce` with short blocks, name the arguments `|a, e|`
  must be writen as `|accumulator, element|`.


3.11. Prefer `map` over `collect`, `find` over `detect`, `select` over
  `find_all`, `reduce` over `inject` and `size` over `length`. This is
  not a hard requirement; if the use of the alias enhances
  readability, it's ok to use it. The rhyming methods are inherited from
  Smalltalk and are not common in other programming languages. The
  reason the use of `select` is encouraged over `find_all` is that it
  goes together nicely with `reject` and its name is pretty self-explanatory.


3.12. Use `reverse_each` instead of `reverse.each`. `reverse_each` doesn't
  do a new array allocation and that's a good thing.

  ```Ruby
  # Wrong way.
  array.reverse.each { ... }

  # Wrong way.
  array.reverse_each { ... }
  ```

## 4. Comments

4.1. Write comments in English.

4.2. Use one space between the leading `#` character of the comment and the text
  of the comment.

4.3. Comments longer than a word are capitalized and use punctuation. Use [one
  space](http://en.wikipedia.org/wiki/Sentence_spacing) after periods.

4.4. Avoid superfluous comments.

  ```Ruby
  # bad
  counter += 1 # Increments counter by one.
  ```

4.5. Keep existing comments up-to-date. An outdated comment is worse than no comment
  at all.

4.6. Avoid writing comments to explain bad code. Refactor the code to
  make it self-explanatory.

4.7. Comment Annotations

4.7.1. Annotations should usually be written on the line immediately above
  the relevant code.

4.7.2. The annotation keyword is followed by a colon and a space, then a note
  describing the problem.

4.7.3. In cases where the problem is so obvious that any documentation would
  be redundant, annotations may be left at the end of the offending line
  with no note. This usage should be the exception and not the rule.

  ```Ruby
  def bar
    sleep 100 # OPTIMIZE
  end
  ```

4.7.4. Use `TODO` to note missing features or functionality that should be
  added at a later date.

4.7.5. Use `FIXME` to note broken code that needs to be fixed.

4.7.6. Use `OPTIMIZE` to note slow or inefficient code that may cause
  performance problems.

4.7.7. Use `HACK` to note code smells where questionable coding practices
  were used and should be refactored away.

4.7.8. Use `REVIEW` to note anything that should be looked at to confirm it
  is working as intended. For example: `REVIEW: Are we sure this is how the
  client does X currently?`

## 5. Classes & Modules

5.1. Use a consistent structure in your class definitions.

  ```Ruby
  class Person
    # extend and include go first
    extend SomeModule
    include AnotherModule

    # inner classes
    CustomErrorKlass = Class.new(StandardError)

    # constants are next
    SOME_CONSTANT = 20

    # afterwards we have attribute macros
    attr_reader :name

    # followed by other macros (if any)
    validates :name

    # public class methods are next in line
    def self.some_method
    end

    # followed by public instance methods
    def some_method
    end

    # protected and private methods are grouped near the end
    protected

    def some_protected_method
    end

    private

    def some_private_method
    end
  end
  ```

5.2. Prefer modules to classes with only class methods. Classes should be
  used only when it makes sense to create instances out of them.

  ```Ruby
  # bad
  class SomeClass
    def self.some_method
      # body omitted
    end

    def self.some_other_method
    end
  end

  # good
  module SomeClass
    module_function

    def some_method
      # body omitted
    end

    def some_other_method
    end
  end
  ```

5.3. Favor the use of `module_function` over `extend self` when you want
  to turn a module's instance methods into class methods.

  ```Ruby
  # bad
  module Utilities
    extend self

    def parse_something(string)
      # do stuff here
    end

    def other_utility_method(number, string)
      # do some more stuff
    end
  end

  # good
  module Utilities
    module_function

    def parse_something(string)
      # do stuff here
    end

    def other_utility_method(number, string)
      # do some more stuff
    end
  end
  ```

5.4. Always supply a proper `to_s` method for classes that represent
  domain objects.

  ```Ruby
  class Person
    attr_reader :first_name, :last_name

    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end

    def to_s
      "#{@first_name} #{@last_name}"
    end
  end
  ```

5.5. Consider adding factory methods to provide additional sensible ways
  to create instances of a particular class.

  ```Ruby
  class Person
    def self.create(options_hash)
      # body omitted
    end
  end
  ```

5.6. Assign proper visibility levels to methods (`private`, `protected`)
  in accordance with their intended usage. Don't go off leaving
  everything `public` (which is the default).

5.7. Indent the `public`, `protected`, and `private` methods as much the
  method definitions they apply to. Leave one blank line above the
  visibility modifier
  and one blank line below in order to emphasize that it applies to all
  methods below it.

  ```Ruby
  class SomeClass
    def public_method
      # ...
    end

    private

    def private_method
      # ...
    end

    def another_private_method
      # ...
    end
  end
  ```

5.8. Use `def self.method` to define singleton methods. This makes the code
  easier to refactor since the class name is not repeated.

  ```Ruby
  class GamaGold
    # Wrong way.
    def GamaGold.real_value
      # body omitted
    end

    # Correct way.
    def self.real_value
      # body omitted
    end
  ```

## 6. Exceptions

6.1. Signal exceptions using the `fail` method. Use `raise` only when
  catching an exception and re-raising it (because here you're not
  failing, but explicitly and purposefully raising an exception).

  ```Ruby
  begin
    fail 'Oops'
  rescue => error
    raise if error.message != 'Oops'
  end
  ```

6.2. Don't specify `RuntimeError` explicitly in the two argument version of `fail/raise`.

  ```Ruby
  # Wrong way.
  fail RuntimeError, 'message'

  # Correct way (signals a RuntimeError by default)
  fail 'message'
  ```

6.3. Do not *implicit begin blocks* where possible.

  ```Ruby
  # Correct way.
  def send_message
    begin
      # Main logic goes here.
    rescue
      # Failure handling goes here.
    end
  end

  # Wrong way.
  def foo
    # main logic goes here
  rescue
    # failure handling goes here
  end
  ```

6.4. Mitigate the proliferation of `begin` blocks by using
  *contingency methods*.

  ```Ruby
  # bad
  begin
    something_that_might_fail
  rescue IOError
    # handle IOError
  end

  begin
    something_else_that_might_fail
  rescue IOError
    # handle IOError
  end

  # good
  def with_io_error_handling
     yield
  rescue IOError
    # handle IOError
  end

  with_io_error_handling { something_that_might_fail }

  with_io_error_handling { something_else_that_might_fail }
  ```

6.5. Don't use exceptions for flow of control.

  ```Ruby
  # Wrong way.
  begin
    n / d
  rescue ZeroDivisionError
    puts 'Cannot divide by 0!'
  end

  # Wrong way.
  if d.zero?
    puts 'Cannot divide by 0!'
  else
    n / d
  end
  ```

## 7. Collections

7.1. Prefer literal array and hash creation notation (unless you need to
  pass parameters to their constructors, that is).

  ```Ruby
  # Wrong way.
  arr = Array.new
  hash = Hash.new

  # Correct way.
  arr = []
  hash = {}
  ```

7.2. Prefer `%w` to the literal array syntax when you need an array of
  words (non-empty strings without spaces and special characters in them).
  Apply this rule only to arrays with two or more elements.

  ```Ruby
  # Wrong way.
  STATES = ['draft', 'open', 'closed']

  # Correct way.
  STATES = %w(draft open closed)
  ```

7.3. Prefer `%i` to the literal array syntax when you need an array of
  symbols. Apply this rule only to arrays with two or more elements.

  ```Ruby
  # Wrong way.
  STATES = [:draft, :open, :closed]

  # Correct way.
  STATES = %i(draft open closed)
  ```

7.4. When accessing the first or last element from an array, prefer `first` or `last` over `[0]` or `[-1]`.

7.5. Use `Set` instead of `Array` when dealing with unique elements. `Set`
  implements a collection of unordered values with no duplicates. This
  is a hybrid of `Array`'s intuitive inter-operation facilities and
  `Hash`'s fast lookup.

7.6. Prefer symbols instead of strings as hash keys.

  ```Ruby
  # Wrong way.
  hash = { 'one' => 1, 'two' => 2, 'three' => 3 }

  # Correct way.
  hash = { one: 1, two: 2, three: 3 }
  ```

7.7. Avoid the use of mutable objects as hash keys.

7.8. Use the Ruby 1.9 hash literal syntax when your hash keys are symbols.

  ```Ruby
  # bad
  hash = { :one => 1, :two => 2, :three => 3 }

  # good
  hash = { one: 1, two: 2, three: 3 }
  ```

7.9. Don't use the Ruby 1.9 hash syntax.

  ```Ruby
  # Wrong way.
  { :a => 1, :b => 2 }

  # Correct way.
  { a: 1, b: 2 }
  ```

## 8. Strings

8.1. Prefer string interpolation and string formatting instead of string concatenation:

  ```Ruby
  # Wrong way.
  email_with_name = user.name + ' <' + user.email + '>'

  # Correct ways.
  email_with_name = "#{user.name} <#{user.email}>"

  email_with_name = format('%s <%s>', user.name, user.email)
  ```

8.2. Consider padding string interpolation code with space. It more clearly sets the
  code apart from the string.

  ```Ruby
  "#{ user.last_name }, #{ user.first_name }"
  ```

8.3. Don't leave out `{}` around instance and global variables being
  interpolated into a string.

  ```Ruby
  class Person
    attr_reader :first_name, :last_name

    def initialize(first_name, last_name)
      @first_name = first_name
      @last_name = last_name
    end

    # Wrong way (valid, but awkward).
    def to_s
      "#@first_name #@last_name"
    end

    # Correct way.
    def to_s
      "#{@first_name} #{@last_name}"
    end
  end
  ```

8.4. Don't use `Object#to_s` on interpolated objects. It's invoked on them automatically.

  ```Ruby
  # Wrong way.
  message = "This is the #{result.to_s}."

  # Wrong way.
  message = "This is the #{result}."
  ```

8.5. Avoid using `String#+` when you need to construct large data chunks.
  Instead, use `String#<<`. Concatenation mutates the string instance in-place
  and is always faster than `String#+`, which creates a bunch of new string objects.

  ```Ruby
  # Correct and faster way.
  html = ''
  html << '<h1>Pick a Project</h1>'

  paragraphs.each { |paragraph|
    html << "<p>#{paragraph}</p>"
  }
  ```

## 9. Regular Expressions

9.1. Don't use regular expressions if you just need plain text search in string:
  `string['text']`

9.2. For simple constructions you can use regexp directly through string index.

  ```Ruby
  match = string[/regexp/]             # get content of matched regexp
  first_group = string[/text(grp)/, 1] # get content of captured group
  string[/text (grp)/, 1] = 'replace'  # string => 'text replace'
  ```

9.3. Use non-capturing groups when you don't use captured result of parentheses.

  ```Ruby
  /(first|second)/   # bad
  /(?:first|second)/ # good
  ```

9.4. Character classes have only a few special characters you should care about:
  `^`, `-`, `\`, `]`, so don't escape `.` or brackets in `[]`.

9.5. Be careful with `^` and `$` as they match start/end of line, not string endings.
  If you want to match the whole string use: `\A` and `\z` (not to be
  confused with `\Z` which is the equivalent of `/\n?\z/`).

  ```Ruby
  string = "some injection\nusername"
  string[/^username$/]   # matches
  string[/\Ausername\z/] # doesn't match
  ```

9.6. Use `x` modifier for complex regexps. This makes them more readable and you
  can add some useful comments. Just be careful as spaces are ignored.

  ```Ruby
  regexp = /
    start         # some text
    \s            # white space char
    (group)       # first group
    (?:alt1|alt2) # some alternation
    end
  /x
  ```

9.7. For complex replacements `sub`/`gsub` can be used with block or hash.

## 10. Percent Literals

10.1. Use `%()`(it's a shorthand for `%Q`) for single-line strings which require both
  interpolation and embedded double-quotes. For multi-line strings, prefer heredocs.

  ```Ruby
  # Wrong way (no interpolation needed).
  %(<div class="text">Pick a Project</div>)
  # Should be '<div class="text">Pick a Project</div>'

  # Wrong way (no double-quotes).
  %(This is #{quality} style)
  # Should be "This is #{ quality } style"

  # Wrong way (multiple lines).
  %(<div>\n<span class="big">#{ exclamation }</span>\n</div>)

  # Correct way (requires interpolation, has quotes, single line).
  %(<tr><td class="name">#{ name }</td>)
  ```

10.2. Use `%r` only for regular expressions matching *more than* one '/' character.

  ```Ruby
  # Wrong way.
  %r(\s+)

  # Still wrong.
  %r(^/(.*)$)
  # should be /^\/(.*)$/

  # Correct way.
  %r(^/blog/2011/(.*)$)
  ```

10.3. Prefer `()` as delimiters for all `%` literals, except `%r`. Since
  braces often appear inside regular expressions in many scenarios a
  less common character like `{` might be a better choice for a
  delimiter, depending on the regexp's content.

  ```Ruby
  # bad
  %w[one two three]
  %q{"Test's king!", John said.}

  # good
  %w(one two three)
  %q("Test's king!", John said.)
  ```

10.4. Avoid `alias` when `alias_method` will do.

10.5. Use `OptionParser` for parsing complex command line options and
`ruby -s` for trivial command line options.

10.6. Prefer `Time.now` over `Time.new` when retrieving the current system time.

10.7. Code in a functional way, avoiding mutation when that makes sense.

10.8. Do not mutate arguments unless that is the purpose of the method.

10.9. Avoid more than three levels of block nesting.

10.10. Be consistent. In an ideal world, be consistent with these guidelines.
