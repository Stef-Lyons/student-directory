@students = []

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu# 1. print the menu and ask the user what to do
# 9 because we'll be adding more items
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end


def show_students()
  print_header
  print_students_list
  print_footer()
end


def process(selection)
  case selection
  when "1"
    input_students
    puts "Student successfully inputted!"
  when "2"
    show_students()
  when "3"
    save_students
    puts "Students successfully saved!"
  when "4"
    load_students
  when "9"
    puts "Programme finished."
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
# Create an empty array
  cohort_months = ["January", "March", "May", "July", "September", "November"]
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Which cohort do they belong to?"
    cohort = handle_default(STDIN.gets.chomp)
    puts "What is the student's main hobby?"
    hobby = handle_default(STDIN.gets.chomp)
    puts "Where is the student's hometown?"
    hometown = handle_default(STDIN.gets.chomp)
    # add the student hash to the array
    if cohort_months.include?(cohort)
    @students << {name: name, cohort: cohort, hobby: hobby, hometown: hometown}
    if @students.count == 1
      puts "Now we have #{@students.count} student, please add another below:"
    else
      puts "Now we have #{@students.count} students, please add another below:"
    end
# get another name from the user
    else
    puts "A valid cohort was not entered, please type another."
  end
  name = STDIN.gets.chomp
end

end


def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end


def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end


def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
    else # if it doesn't exist
      puts "Sorry #{filename} doesn't exist."
      exit # quit the programme
    end
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


def print_students_list
  @students.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
  end
end

def print_footer()
  puts "Overall, we have #{@students.count} great students".center(50)
end

try_load_students
interactive_menu
# nothing happens until we call the methods
if @students.count == 0
  puts "No information entered."
else
  sorted_students = @students.sort_by { |student| student[:cohort] }
  print_header
  print_students_list(sorted_students)
  print_footer()
end
