# Healthy demo seed data for ExpenseTracker
# Creates demo users, budgets, budget categories, and expenses

puts "Seeding demo data..."

User.transaction do
	demo = User.find_or_create_by!(email: "demo@example.com") do |u|
		u.password = "password"
		u.password_confirmation = "password"
	end

	secondary = User.find_or_create_by!(email: "alice@example.com") do |u|
		u.password = "password"
		u.password_confirmation = "password"
	end

	# Current month budget for demo user
	current_start = Date.current.beginning_of_month
	budget = demo.budgets.find_or_initialize_by(title: "Monthly Budget", period_start: current_start)
	budget.income_per_month = 5000.00
	budget.save!

	categories = [
		["Groceries", 400.0],
		["Leisure", 150.0],
		["Electronics", 200.0],
		["Utilities", 120.0],
		["Clothing", 100.0],
		["Health", 75.0]
	]

	categories.each do |name, amount|
		budget.budget_categories.find_or_create_by!(name: name) do |c|
			c.amount = amount
		end
	end

	# Create several expenses within current budget period
	demo.expenses.create!(name: "Supermarket Shopping", category: "Groceries", amount: 250.0, date: Date.current - 5)
	demo.expenses.create!(name: "Weekend Dinner", category: "Leisure", amount: 180.0, date: Date.current - 10)
	demo.expenses.create!(name: "Electric Bill", category: "Utilities", amount: 130.0, date: Date.current - 12)
	demo.expenses.create!(name: "New T-Shirt", category: "Clothing", amount: 60.0, date: Date.current - 3)
	demo.expenses.create!(name: "Doctor Visit", category: "Health", amount: 45.0, date: Date.current - 2)
	demo.expenses.create!(name: "Headphones", category: "Electronics", amount: 250.0, date: Date.current - 20)

	# A few smaller expenses to show variety
	demo.expenses.create!(name: "Coffee", category: "Leisure", amount: 12.0, date: Date.current - 1)
	demo.expenses.create!(name: "Bus Fare", category: "Utilities", amount: 2.5, date: Date.current - 4)

	# Previous month budget + expenses
	prev_start = (Date.current - 1.month).beginning_of_month
	prev_budget = demo.budgets.find_or_initialize_by(title: "Previous Month", period_start: prev_start)
	prev_budget.income_per_month = 4800.00
	prev_budget.save!
	prev_budget.budget_categories.find_or_create_by!(name: "Groceries") { |c| c.amount = 350.0 }
	demo.expenses.create!(name: "Last Month Supermarket", category: "Groceries", amount: 320.0, date: prev_start + 5)

	# Secondary user sample data
	s_budget_start = Date.current.beginning_of_month
	s_budget = secondary.budgets.find_or_initialize_by(title: "Alice Budget", period_start: s_budget_start)
	s_budget.income_per_month = 3000.0
	s_budget.save!
	s_budget.budget_categories.find_or_create_by!(name: "Groceries") { |c| c.amount = 300.0 }
	secondary.expenses.create!(name: "Alice Grocery", category: "Groceries", amount: 120.0, date: Date.current - 7)
end

puts "Seeding complete."
