Feature: Student allocation to teaching assistants
  As a system admin
  I want to allocate students to responsible teaching assistants
  So that teaching assistants can monitor and grade their students' exercises

Scenario: Successfully assign a student to a monitor (web)
  Given student "Fernanda" has a worksheet pending review
  And monitor "Lucas" is registered with "Available" status
  And I am on the "Monitor Allocation" page
  When I confirm the assignment of student "Fernanda" to monitor "Lucas"
  Then I see monitor "Lucas" assigned to student "Fernanda" in the allocation list
  And I see the worksheet status updated to "Allocated"

Scenario: Attempting to assign a student to an unavailable monitor
  Given the monitor "Maria" has the status "Unavailable"
  And the student "João" has the status "Unassigned"
  And I am on the "Monitor Allocation" page
  When I attempt to assign the student "João" to the monitor "Maria"
  Then I see the error message "The monitor is not available"
  And I see the student "João" with the status "Unassigned" in the list