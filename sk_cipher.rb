# frozen_string_literal: true

require 'base64'
require 'rbnacl'

module ModernSymmetricCipher
  def self.generate_new_key
    # TODO: Return a new key as a Base64 string
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    Base64.strict_encode64(key)
  end

  def self.encrypt(document, key)
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
    key = Base64.strict_decode64(key)
    box = RbNaCl::SecretBox.new(key)
    nonce = RbNaCl::Random.random_bytes(box.nonce_bytes)
    ciphertext = box.encrypt(nonce, document.to_s)
    Base64.strict_encode64(nonce + ciphertext)
  end

  def self.decrypt(encrypted_cc, key)
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key
    key = Base64.strict_decode64(key)
    box = RbNaCl::SecretBox.new(key)
    encrypted_cc = Base64.strict_decode64(encrypted_cc)
    nonce = encrypted_cc[0...box.nonce_bytes]
    ciphertext = encrypted_cc[box.nonce_bytes..-1]
    box.decrypt(nonce, ciphertext)  
  end
end
