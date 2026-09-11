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

Scenario: Try to allocate student without pending worksheets
  Given the student "Carlos" has no pending worksheets
  And I am at the "Student Allocation" page
  When I try to allocate the student "Carlos" to teaching assistant "Maria"
  Then I see the error message "Student has no pending worksheets to evaluate"
  And I see the student "Carlos" with status "Unallocated"
  And I see teaching assistant "Maria" available for other allocations

Scenario: Attempting to assign a student already assigned to another monitor
  Given student "Bruno" is assigned to monitor "Lucas"
  And monitor "Maria" has the status "Available"
  And I am on the "Monitor Allocation" page
  When I attempt to assign student "Bruno" to monitor "Maria"
  Then I see the error message "The student already has an assigned monitor"
  And I see monitor "Lucas" remain as the person responsible for student "Bruno" in the list

Scenario: Successfully list all monitors available
  Given the monitors "Lucas" and "Maria" have the status "Available"
  And the monitor "Pedro" has the status "Unavailable"
  And I am on the "Monitor Allocation" page
  When I request to view the available monitors
  Then I see the monitors "Lucas" and "Maria" in the list of available monitors
  And I do not see the monitor "Pedro" in the list of available monitors

