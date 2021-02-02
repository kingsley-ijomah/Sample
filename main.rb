class Node
  attr_reader :name, :children
  def initialize(name)
    @name = name
    @children = []
  end

  def <<(other)
    @children << other
  end
end

# Treat as a strongly connected directed graph
# need to track visited nodes to prevent infinite loops
# in a case of cyclic reference between nodes.

def fully_connected?(root_node, count)
  visited = [root_node]
  to_visit = [root_node]
  
  while !to_visit.empty?
    current_node = to_visit.shift

    current_node.children.each do |node|
      if !visited.include?(node)
        visited << node
        to_visit << node # get children next cycle
      end
    end
  end

  puts visited.count == count
end

# ----- -----
# | a  |  b  |
# ----- -----
# | c  |  d  |
# ----- -----
#
# 1. -> a, a -> b, a -> c, c -> d  => true (all nodes connect)
a = Node.new(:a)
b = Node.new(:b)
c = Node.new(:c)
d = Node.new(:d)

a << b
a << c
c << d

#=> true
fully_connected?(a, 4)


# 1. -> a, a -> b, a -> c, c -> b, c -> a, b -> c  => false (d is not connected)
aa = Node.new(:a)
bb = Node.new(:b)
cc = Node.new(:c)
dd = Node.new(:d)

aa << bb
aa << cc
cc << bb
cc << aa
bb << cc

# #=> false
fully_connected?(aa, 4)


