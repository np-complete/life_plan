# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
LifePlan::Application.config.secret_key_base = ENV['SECRET'] || '6a10369f839874ba9d82c5ce78e8a1de3dbea62b709303ba9a789a26c4dbdad97b5efb6e5d3ba68c53f822d20741c96de126c6cf7f848e593e8739cf3159d150'
