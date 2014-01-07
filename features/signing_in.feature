# High-level cucumber file describing tests.
# The implementation of these can be found in /features/step_definitions/authentication_steps.rb

Feature: Signing in

	Scenario: Unsuccessful signin
		Given a user visits the signin page
		When they submit invalid signin information
		Then they should see an error message
		
	Scenario: Successful signin
		Given a user visits the signin page
			And the user has an account
			
		When the user submits valid signin information
		Then they should see their profile page
			And they should see a signout link