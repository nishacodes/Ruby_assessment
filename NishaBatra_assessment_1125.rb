# 1. ARRAYS
array = ["Blake","Ashley","Jeff"]

# 1a. adds an element to the array
array << "Adam" 

# 1b. prints elements of the array
array.each {|name| puts name}

# 1c. returns value at index 1 => Ashley
array[1] 

# 1d. returns index for "Jeff" => 2
array.index("Jeff") 


# 2. HASHES

instructor = {:name=>"Ashley", :age=>27}

# 2a. adds key-value pair :location=>"NYC"
instructor[:location]="NYC" 

# 2b. prints all the key-value pairs
instructor.each {|key,value| puts "#{key}: #{value}" }

# 2c. returns the name value
instructor[:name] 

# 2d. returns the key for value = 27
instructor.key(27)


# 3. NESTED STRUCTURES

school = { 
	:name => "Happy Funtime School",
	:location => "NYC",
	:instructors => [ 
		{:name=>"Blake", :subject=>"being awesome" },
		{:name=>"Ashley", :subject=>"being better than blake"},
		{:name=>"Jeff", :subject=>"karaoke"}
	],
	:students => [ 
		{:name => "Marissa", :grade => "B"},
		{:name=>"Billy", :grade => "F"},
		{:name => "Frank", :grade => "A"},
		{:name => "Sophie", :grade => "C"}
	]
}
# set variables for students and instructors to make easier to navigate
instructors = school[:instructors]
students = school[:students]

# 3a. adds key-value pair :founded_in=>2013 to the school hash
school[:founded_in]=2013 

# 3b. adds a student to the students array
school[:students] << {:name=>"Bob", :grade=>"B"} 

# 3c. removes Billy from the students array

student = "Billy"
school[:students].each_with_index do |studenthash, index|
	studenthash.each do |attribute, value|
		school[:students].delete_at(index) if studenthash[attribute] == student
	end
end

# 3d. adds a key-value pair to every student :semester=>"Summer"
school[:students].each do |hash|  
	hash[:semester] = "Summer"
end

# 3e. changes Ashley's subject
instructor = "Ashley"
new_subject = "being almost better than Blake"

school[:instructors].each do |hash|
		hash[:subject] = new_subject if hash[:name] == instructor
end

# 3f. changes Frank's grade to an F. Poor Frank. (Note: Billy has already been removed)
student = "Frank"
initial_grade = "A"
new_grade = "F"

school[:students].each do |hash| 
	hash[:grade] = new_grade if hash[:name] == student
end

# 3g. checks through each hash in the students array, where student = x
grade = "B"

school[:students].each do |hash|       
	hash[:name] if hash[:grade] == grade
end


# 3h. returns Jeff's subject
instructor = "Jeff"
school[:instructors].each do |hash|
	hash[:subject] if hash[:name] == instructor
end

# 3i. THE FOLLOWING CODE SHOULD PRINT THIS STATEMENT:
	# Happy Funtime School is the best school in NYC. The instructors are awesome -- 
	# Blake, who lives for being awesome, Ashley who lives for being better than Blake, Jeff who lives for karoake. 
	# The students of the summer session work hard, but poor Frank is struggling. 
	# Their grades are as follows. Marissa: B, Frank: F, Sophie: C, Bob: B.

school.each do |key, value|
	if value.class == String
		puts "The #{key} is #{value}."
	else
		puts "The #{key} are listed below:"
		value.each do |hash|
			hash.each do |key2, value2|
				puts "#{key2}: #{value2}"
			end
		end
	end
end


# # Note: the punctation is a bit off.

# string= "#{school[:name]} is the best school in #{school[:location]}. The instructors are awesome --"

# school[:instructors].each do |x|
# 		string << " " << "#{x[:name]}, who lives for #{x[:subject]},"
# end

# string << " The students of the #{school[:session]} session work hard, but poor #{school[:students][1][:name]} is struggling. Their grades are as follows. "

# school[:students].each do |x|
# 		string << "" << "#{x[:name]}: #{x[:grade]}, "
# end

# puts string


# 4. METHODS

# define SCHOOL as a constant to use in all of the below methods
SCHOOL = { 
	:name => "Happy Funtime School",
	:location => "NYC",
	:instructors => [ 
		{:name=>"Blake", :subject=>"being awesome" },
		{:name=>"Ashley", :subject=>"being better than blake"},
		{:name=>"Jeff", :subject=>"karaoke"}
	],
	:students => [ 
		{:name => "Marissa", :grade => "B"},
		{:name=>"Billy", :grade => "F"},
		{:name => "Frank", :grade => "A"},
		{:name => "Sophie", :grade => "C"}
	]
}
	# 4a. returns the grade of a student, given the student's name
	def student_grade(student_name)
		SCHOOL[:students].each do |hash|
			return hash[:grade] if hash[:name]==student_name
		end
	end

	student_grade("Billy") 

	# 4b. updates the instructors subject, given name and new subject
	def update_subject(instructor_name, new_subject)
		SCHOOL[:instructors].each do |x|
			x[:subject]=new_subject if x[:name]==instructor_name
		end
	end

	update_subject("Blake","being terrible")

	# 4c. adds a new student to the students array
	def add_student(student_name, student_grade)
		@school[:students] << {:name=> student_name, :grade=>student_grade}
	end

	add_student("Nisha","A")

	# 4d. adds a new key at the top level of the school hash :ranking=>1
	def add_key(key,value)   
		@school[key]=[value]
	end
	
	add_key(:ranking,1)

# 5. OBJECT ORIENTATION


class School
	attr_accessor :name, :location, :instructors, :students
	attr_reader :ranking

	SCHOOLS = [] 
	
	def initialize (name, location, ranking) 
		@name = name
		@location = location
		@ranking = ranking
		@instructors = []
		@students = []
		SCHOOLS << self 
	end
	
	# 5d. sets the ranking
	def set_ranking(ranking)
		@ranking = ranking 
	end

	# 5e. adds a student to the school given name, grade and semester
	def add_student(name, grade, semester)
		@students << {:name=>name, :grade=>grade, :semester=>semester}
	end

	# 5e. removes a student given a name
	def remove_student(name)
		@students.each do |hash|
			@students.delete(hash) if hash[:name]==name
		end
	end
end

# examples of calling the above methods
flatironschool = School.new("Flatiron School","NYC",1)
flatironschool.set_ranking(2)
flatironschool.add_student("nisha","A","Summer") 
flatironschool.remove_student("nisha")


# 6. CLASSES

class Student 
	attr_accessor :name, :grade

	def initialize (name,grade)
		@name = name
		@grade = grade
	end
end

class School
	attr_accessor :name, :location, :instructors, :students, :student_name
	attr_reader :ranking

	SCHOOLS = [] 
	
	def initialize (name, location, ranking) 
		@name = name
		@location = location
		@ranking = ranking
		@instructors = []
		@students = []
		SCHOOLS << self 
	end
	
	# sets the ranking
	def set_ranking(ranking)
		@ranking = ranking 
	end

	# adds a student to the school given name, grade and semester
	def add_student(*student)
		# @students << student
	end

	# removes a student given a name 
	def remove_student(student_name)
		@students.each do |student|
			@students.delete(student) if student.name==student_name
		end
	end

	# finds a student by name and returns the student object
	def find_student(student_name)
		@students.each do |student|
			puts student.name if student.name == student_name
		end
	end
end

student1 = Student.new("Nisha","A")                  # creates a new student object called student1
student2 = Student.new("Joe","A")                    # creates a new student object called student2
flatiron = School.new("Flatiron School","NYC",1)     # creates a new school object called flatiron
flatiron.add_student(student1)  
flatiron.add_student(student2)                       # adds both students to the students array
student = flatiron.find_student("Joe")               # returns the student object with name "Joe"
flatiron.remove_student("Joe")                       # removes stude with name "Joe"


# 7. SELF

# 7a
# hello
# Student

# 7b
# Student

# 7c
# nil

# 7d
# Student

# 7e
# goodbye

