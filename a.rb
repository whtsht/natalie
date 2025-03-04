module ModuleM
  @@cvar_m = :value

  def a
    "a"
  end

  def cvar_m
    @@cvar_m
  end
end

class ClassC
  extend ModuleM
end

puts ClassC.a
