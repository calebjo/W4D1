require "byebug"

class PolyTreeNode

    attr_accessor :parent, :children, :value

    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def parent
        @parent
    end

    def children
        @children
    end

    def value
        @value
    end

    def parent=(node)
        # debugger 
        if !node.nil?
            node.children << self if !node.children.include?(self)
            # debugger
            node.parent.children.delete(self) if !node.parent.nil?
        end
        @parent = node
        # debugger
    end

    def add_child(node)
        # debugger
        node.parent = self
        children << node if !children.include?(node)
        # debugger
    end

    def remove_child(node)
        if !self.children.include?(node)
            raise Exception.new("Node is not a child")
        end
        node.parent = nil
        children.delete(node)
    end

    def dfs(target_value)
        return self if value == target_value
        children.each do |child|
            val = child.dfs(target_value)
            return val if !val.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            current = queue.shift
            return current if current.value == target_value

            current.children.each do |child|
                queue << child
            end
        end
        nil
    end

end