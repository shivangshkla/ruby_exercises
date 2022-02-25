class Node
	attr_accessor :next_node, :value
	def initialize(value = nil,next_node = nil)
		@next_node = next_node
		@value = value
	end
end
class LinkedList
	def initialize
		@head = nil
		@tail = nil
		@node = 0
	end
	def append(value)
	    @node = @node + 1
		new_node = Node.new(value)
		if @head.nil?
			@head = new_node
			@tail = new_node
		else
			@tail.next_node = new_node
			@tail = new_node
	    end
	end
	def prepend(value)
		@node = @node + 1
		new_node = Node.new(value,@head)
		if @head.nil?
			@head = new_node
			@tail = new_node
		else
			@head = new_node
	    end
	end
	def size
		puts @node
	end
	def head
		puts @head.value
	end
	def tail
		puts @tail.value
	end
	def at(index)
		i = 0
		current_node = @head
		until i == index
			current_node = current_node.next_node
			i = i + 1
		end
		current_node
	end
	def pop()
		if @head.nil?
			puts "Empty list"
		else
		    value = @tail.value
			current_node = @head
			until current_node.next_node == @tail
				current_node = current_node.next_node
			end
			current_node.next_node = nil
			@tail = current_node
			puts "Popped element: #{value}"
		end
	end
	def contains?(value)
		current_node = @head
		until current_node.nil?
			if current_node.value == value
				return true
			end
			current_node = current_node.next_node
		end
		return false
	end
	def find(value)
		current_node = @head
		i = 0
		until current_node.nil?
			if current_node.value == value
				return i
			end
			current_node = current_node.next_node
			i = 0
		end
		return nil
	end
	def insert_at(value,index)
		if index == 0
			prepend(value)
		elsif index == size
			append(value)
		else
			new_node = Node.new(value, at(index))
			prev_node = at(index - 1)
			prev_node.next_node = new_node
		end
	end
	def remove_at(index)
		if index == size || index == 0
			pop
		else
			prev_node = at(index - 1)
			prev_node.next_node = at(index + 1)
		end
	end
	def to_s
		current_node = @head
		until current_node.nil?
			if current_node == @tail
				print "(#{current_node.value})"
			else
				print "(#{current_node.value}) -> "
			end
			current_node = current_node.next_node
		end
	end
end
my_list = LinkedList.new
my_list.append('last')
my_list.prepend('first')
my_list.prepend('first')
my_list.prepend('yo')
my_list.size
my_list.head
my_list.tail
puts my_list.at(2).value
my_list.pop
puts my_list.contains?("last")
puts my_list.contains?("first")
puts my_list.find("yo")
my_list.insert_at("he",1)
my_list.insert_at("yup",3)
my_list.insert_at("he",4)
my_list.remove_at(1)
my_list.to_s