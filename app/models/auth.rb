module Auth
  def self.admins
    {"U02MYKGQB" => "Horace", "U02H7KFLL" => "Raissa", "U02D2TTKD" => "Rachel", "U029P2S9P" => "Jeff C",
     "U02GA9USU" => "Steve", "U02C40LBY" => "Josh M.", "U03P5UB9G" => "Daisha", "U02Q25H6V" => "Mike",
     "U029PR5TG" => "Jorge", "U046S1HSC" => "Jason Noble", "U03JY2TLJ" => "Tess G",
     "U03J8R009" => "Andrew C", "U02DYKWQG" => "Mary C"}
  end

  def self.admin_uid?(uid)
    admins.keys.include?(uid)
  end
end
