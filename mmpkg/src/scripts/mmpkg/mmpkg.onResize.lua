local debounce = false
function mmpkg.onResize(event, x, y)
  if debounce then
    return
  end
  debounce = true
  tempTimer(
    0.020,
    function()
      debounce = false
    end
  )
  w, _ = getMainWindowSize()
  setBorderRight(w * .405)
  setWindowWrap("main", getColumnCount() - 1)
end
