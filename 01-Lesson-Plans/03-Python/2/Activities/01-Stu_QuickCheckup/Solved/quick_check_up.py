# Print Hello User!
print("Hello User!")

# Take in User Input
name = input("What is your name? ")

# Respond Back with User Input
print("Hi " + name + "!")

# Take in the User Age
age = input("What is your age? ")

# Respond Back with a statement based on age
if (int(age) < 8):
    print("Aww! You are just a baby!")

elif (int(age) >= 8):
    print("Ah... A well traveled soul are ye!")

# Alternatively you could add else at the end of that conditional
# if (int(age) < 8):
#     print("Aww! You are just a baby!")
# elif (8 <= int(age) <= 16):
#     print("Ah... You are a kid!")
# else:
#     print("Ah... A well traveled soul are ye!")
