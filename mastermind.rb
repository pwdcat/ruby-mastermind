def guessor_prompt
  loop do
    print 'Do you want to be the guesser? (Y/N) '
    answer = gets.chomp.downcase
    return true  if %w[y yes].include?(answer)
    return false if %w[n no].include?(answer)

    puts "Please enter 'Y' or 'N'"
  end
end

def valid_input?(answer, a, b)
  answer.match?(/\A\d+\z/) && answer.to_i.between?(a, b)
end

def secret_combo(combo)
  loop do
    print "Enter a number 1-9 for digit #{combo.length + 1}, max 4: "
    answer = gets.chomp
    combo += valid_input?(answer, 1, 9) ? answer : ''
    return combo if combo.length == 4
  end
end

def guess
  loop do
    print 'Enter your guess. (1000 - 9999): '
    answer = gets.chomp
    return answer if valid_input?(answer, 1000, 9999)

    puts 'Invalid Number'
  end
end

def feedback(string, combo)
  display = ['', '', '', '']
  string.each_char.with_index do |char, index|
    display[index] = 'CORRECT' if char == combo[index]
    display[index] = 'PRESENT' if combo.include?(char) && display[index] == ''
  end
  display
end

def player_guessor(combo)
  12.times do
    answer = guess
    if answer == combo
      p "Congrats! You've won!"
      exit
    end
    p feedback(answer, combo)
  end

  puts "Sorry, you've ran out of guesses"
end

def computer_guessor(combo)
  confirmed = ['', '', '', '']
  answer = rand(1000..9999).to_s
  12.times do
    output = feedback(answer, combo)
    output.each_with_index do |string, index|
      confirmed[index] = answer[index] if string == 'CORRECT'
    end
    answer = rand(1000..9999).to_s
  end
  confirmed == combo ? puts('You Failed!') : puts('You Won!')
end

combo = ''
is_player_guessor = guessor_prompt

combo = is_player_guessor ? rand(1000..9999).to_s : secret_combo(combo)

is_player_guessor ? player_guessor(combo) : computer_guessor(combo)
