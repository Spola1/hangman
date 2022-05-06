class Game
  # Количество допустимых ошибок
  TOTAL_ERRORS_ALLOWED = 7

  # Конструктор класса Game на вход получает строку с загаданным словом.
  #
  # В конструкторе инициализируем две переменные экземпляра: массив букв
  # загаданного слова и пустой массив для дальнейшего сбора в него вводимых
  # букв.
  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def normalize_letter(letter)
    return 'Е' if letter == 'Ё'
    return 'И' if letter == 'Й'

    letter
  end

  def normalized_letters
    @letters.map { |letter| normalize_letter(letter) }
  end

  def errors
    @user_guesses - normalized_letters
  end

  # Возвращает количество ошибок, сделанных пользователем
  def errors_made
    errors.length
  end

  # Отнимает от допустимого количества ошибок число сделанных ошибок и
  # возвращает оставшееся число допустимых ошибок
  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
     result =
       @letters.map do |letter|
         if @user_guesses.include?(normalize_letter(letter))
           letter
         end
       end
     result
   end

  # Возвращает true, если у пользователя не осталось ошибок, т.е. игра проиграна
  def lost?
    errors_allowed == 0
  end

  # Возвращает true, если игра закончена (проиграна или выиграна)
  def over?
    won? || lost?
  end

  def play!(letter)
    if !over? && !@user_guesses.include?(normalize_letter(letter))
      @user_guesses << normalize_letter(letter)
    end
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  # Возвращает загаданное слово, склеивая его из загаданных букв
  def word
    @letters.join
  end
end
