def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp# 3. do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end


def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
# Create an empty array
  cohort_months = ["January", "March", "May", "July", "September", "November"]
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Which cohort do they belong to?"
    cohort = handle_default(gets.chomp)
    puts "What is the student's main hobby?"
    hobby = handle_default(gets.chomp)
    puts "Where is the student's hometown?"
    hometown = handle_default(gets.chomp)
    # add the student hash to the array
    if cohort_months.include?(cohort)
    students << {name: name, cohort: cohort, hobby: hobby, hometown: hometown}
    if students.count == 1
      puts "Now we have #{students.count} student, please add another below:"
    else
      puts "Now we have #{students.count} students, please add another below:"
    end
# get another name from the user
    else
    puts "A valid cohort was not entered, please type another."
  end
  name = gets.chomp
end
  # return the array of students
  students
end

def handle_default(answer)
  if answer.empty?
    return "Response not entered"
  else
    return answer
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end


def print(students)
  students.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(50)
end

interactive_menu
# nothing happens until we call the methods
if students.count == 0
  puts "No information entered."
else
  sorted_students = students.sort_by { |student| student[:cohort] }
  print_header
  print(sorted_students)
  print_footer(students)
end
