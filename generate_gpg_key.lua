#!/usr/bin/env lua

local KEY_LENGTH = 4096
local EXPIRATION_DAYS = 3650
local EMAIL = "your.email@example.com"
local NAME = "Your Name"

io.write("Enter your email address: ")
EMAIL = io.read("*line")
io.write("Enter your full name: ")
NAME = io.read("*line")

print("Generating GPG key for " .. NAME .. " <" .. EMAIL .. ">...")
os.execute("gpg --batch --passphrase '' --quick-generate-key '" .. NAME .. " <" .. EMAIL .. ">' ed25519 cert 0")
local handle = io.popen("gpg --list-secret-keys --keyid-format LONG | grep -E '^sec' | awk '{print $2}' | cut -d'/' -f2 | cut -d' ' -f1")
local KEY_ID = handle:read("*a"):gsub("%s*$", "")
handle:close()
print("Generated GPG key with ID: " .. KEY_ID)

os.execute("gpg --quick-set-expire " .. KEY_ID .. " " .. EXPIRATION_DAYS)
os.execute("gpg --armor --export " .. KEY_ID .. " > public_key.asc")
os.execute("gpg --armor --export-secret-keys " .. KEY_ID .. " > private_key.asc")

print("GPG key generated successfully.")
print("Public key saved to public_key.asc")
print("Private key saved to private_key.asc")

