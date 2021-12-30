Neovim.plugin do |plug|
  plug.command(:LookupUnderCursor) do |nvim|
  end

  plug.command(:LookupSearch, nargs: 1) do |nvim, query|
  end
end
