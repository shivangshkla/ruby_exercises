class Node
	attr_accessor :data,:left,:right
	def initialize(data = nil,left = nil, right = nil)
		@data = data
		@left = left
		@right = right
	end
end
class Tree
	attr_reader :root,:level
	@root
	def initialize(array)
		@array = array.uniq.sort
		@root = build_tree(@array)
	end
	def build_tree(array = @array)
		if array.empty?
			return nil
		end
		mid = array.length/2
		root = Node.new(array[mid])
		root.left = build_tree(array[0...mid])
		root.right = build_tree(array[mid+1..array.length])
		return root
	end
	def insert(value,node = @root)
		if node.data == value
			return node
		elsif node.data < value
			if	node.right == nil
				node.right = Node.new(value)
			else
				insert(value,node.right)
			end
		else
			if	node.left == nil
				node.left = Node.new(value)
			else
				insert(value,node.left)
			end
		end
	end
	def delete(value,node = @root)
		return node if node.nil?

		if value < node.data
			node.left = delete(value, node.left)
		elsif value > node.data
			node.right = delete(value, node.right)
		else
			# if node has one or no child
		return node.right if node.left.nil?
		return node.left if node.right.nil?

      # if node has two children
		leftmost_node = leftmost_leaf(node.right)
      node.data = leftmost_node.data
      node.right = delete(leftmost_node.data, node.right)
    end
    node
	end
	def find(value,node = @root)
	    return nil if node == nil
		if value == node.data
			return node
		elsif value > node.data
			find(value,node.right)
		else 
			find(value,node.left)
		end
	end
	def level_order(node = @root)
		if node == nil
			return
		end
		queue = []
		queue.append(node)
		while queue.length != 0
			current_node = queue[0]
			print " "
			if current_node.left != nil
				queue.append(current_node.left)
			end
			if current_node.right != nil
				queue.append(current_node.right)
			end
			queue.shift
		end
		puts
	end
	def preorder(node = @root)
		return if node.nil?
		print "#{node.data} "
		preorder(node.left)
		preorder(node.right)
	end
	def postorder(node = @root)
		return if node.nil?
		print "#{node.data} "
		postorder(node.right)
		postorder(node.left)
	end
	def inorder(node = @root)
		return if node.nil?
		inorder(node.left)
		print "#{node.data} "
		inorder(node.right)
	end
	def height(node = @root)
		return -1 if node.nil?
		left = height(node.left)
		right = height(node.right)
		return [left,right].max + 1
	end
	def depth(node = @root)
		i = 0
		current_node = @root
		while node != current_node.data
			if current_node.data < node
				i = i + 1
				current_node = current_node.right
			elsif current_node.data > node
				i = i + 1
				current_node = current_node.left
			end
		end
		return i
	end
	def balanced?(node = @root)
		return true if node.nil?

		left_height = height(node.left)
		right_height = height(node.right)

		return true if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)

		false
	end
	def level_order_array(node = @root)
		if node == nil
			return
		end
		array = []
		queue = []
		queue.append(node)
		while queue.length != 0
			current_node = queue[0]
			array.append(current_node.data)
			if current_node.left != nil
				queue.append(current_node.left)
			end
			if current_node.right != nil
				queue.append(current_node.right)
			end
			queue.shift
		end
		array
	end
	def rebalance
		@data = level_order_array.sort
		@root = build_tree(@data)
	end
	def pretty_print(node = @root, prefix = '', is_left = true)
		pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
		puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
		pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
	end
end
array = (Array.new(15) { rand(1..100) })
my_tree = Tree.new(array)
my_tree.build_tree
my_tree.pretty_print
puts my_tree.balanced?
my_tree.inorder
puts
my_tree.postorder
puts
my_tree.preorder
puts
my_tree.insert(500)
my_tree.insert(600)
my_tree.insert(780)
my_tree.insert(520)
my_tree.pretty_print
puts my_tree.balanced?
my_tree.rebalance
my_tree.pretty_print
puts my_tree.balanced?
my_tree.inorder
puts
my_tree.postorder
puts
my_tree.preorder
puts