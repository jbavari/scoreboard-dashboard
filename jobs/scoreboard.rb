require 'sequel'


DB = Sequel.connect('postgres://localhost/scoreboard')
scoreboard = DB[:scoreboard]

send_event('games-played', { value: scoreboard.count })

SCHEDULER.every '30s' do
  send_event('games-played', { value: scoreboard.count })
  send_event('teams', { items: scoreboard.pluck('visitor_team') })
end
