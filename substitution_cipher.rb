# frozen_string_literal: true

module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      string = document.to_s
      key = key.to_i
      encrypted = string.chars.map { |x| (x.ord + key) }
      encrypted.map { |x| x.chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      string = document.to_s
      key = key.to_i
      decrypted = string.chars.map { |x| (x.ord - key)}
      decrypted.map { |x| x.chr }.join
    end
  end

  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      lookup_table = (0..127).to_a.shuffle(random: Random.new(key.to_i))
      string = document.to_s
      encrypted = string.chars.map { |x| lookup_table[x.ord] }
      encrypted.map { |x| x.chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      lookup_table = (0..127).to_a.shuffle(random: Random.new(key.to_i))
      decrypted_lookup = Array.new(128)
      lookup_table.each_with_index { |encrypt, ori| decrypted_lookup[encrypt] = ori }
      string = document.to_s
      decrypted = string.chars.map { |x| decrypted_lookup[x.ord] }
      decrypted.map { |x| x.chr }.join
    end
  end
end
