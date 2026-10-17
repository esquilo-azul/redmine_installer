echo "
  <IfModule mod_passenger.c>
       PassengerRoot $(programeiro /passenger/root)
       PassengerDefaultRuby $(programeiro /ruby/path)
       PassengerStartTimeout ${passenger_start_timeout}
  </IfModule>"
