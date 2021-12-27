# frozen_string_literal: true

require './list.rb'

# Class for the final Todo Board
class TodoBoard
  def initialize(_label)
    @list = {}
  end

  def get_command
    print "\nEnter a command: "
    cmd, label, *args = gets.chomp.split(' ')

    case cmd
    when 'mklist'
      @list[label] = List.new(label)
    when 'ls'
      @list.keys.each { |key| puts key }
    when 'showall'
      @list.each_value(&:print)
    when 'mktodo'
      @list[label].add_item(*args)
    when 'up'
      @list[label].up(*args.map(&:to_i))
    when 'down'
      @list[label].down(*args.map(&:to_i))
    when 'swap'
      @list[label].swap(*args.map(&:to_i))
    when 'sort'
      @list[label].sort_by_date!
    when 'priority'
      @list[label].print_priority
    when 'print'
      args.empty? ? @list[label].print : @list[label].print_full_item(*args.map(&:to_i))
    when 'toggle'
      @list[label].toggle_item(*args.map(&:to_i))
    when 'rm'
      @list[label].remove_item(*args.map(&:to_i))
    when 'purge'
      @list[label].purge
    when 'quit'
      return false
    else
      print 'Sorry, that command is not recognized.'
    end

    true
  end

  def run
    loop do
      return unless get_command
    end
  end
end
