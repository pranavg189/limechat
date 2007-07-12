# Created by Satoshi Nakagawa.
# You can redistribute it and/or modify it under the Ruby's license or the GPL2.

class ListView < OSX::NSTableView
  include OSX
  
  def countSelectedRows
    selectedRowIndexes.count.to_i
  end

  def selectedRows
    ary = []
    set = selectedRowIndexes
    i = set.firstIndex.to_i
    return ary if i == NSNotFound
    ary << i
    (set.count.to_i-1).times do
      i = set.indexGreaterThanIndex(i).to_i
      break if i == NSNotFound
      ary << i
    end
    ary
  end
  
  def select(index, extendSelection=false)
    selectRowIndexes_byExtendingSelection(NSIndexSet.indexSetWithIndex(index), extendSelection)
  end
  
  def selectRows(indices, extendSelection=false)
    set = NSMutableIndexSet.alloc.init
    indices.each {|i| set.addIndex(i) }
    selectRowIndexes_byExtendingSelection(set, extendSelection)
  end
  
  def rightMouseDown(event)
    p = convertPoint_fromView(event.locationInWindow, nil)
    i = rowAtPoint(p)
    if i >= 0
      unless selectedRowIndexes.containsIndex(i)
        select(i)
      end
    else
      #deselectAll(self)
    end
    super_rightMouseDown(event)
  end
end
