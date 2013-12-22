User.delete_all
User.create(id: 0, name: "guest", password: "111", password_confirmation: "111", surname: nil, firstname: nil, date_of_birth: nil, main_location_id: nil)
User.create(id: 1, name: "admin", password: "111", password_confirmation: "111")
3.times do |i|
  (11..15).each do |j|
    User.create(id: (i*100+j),name: "user "+(i*100+j).to_s, password: "111", password_confirmation: "111", surname: "USER "+(i*100+j).to_s, firstname: "user "+(i*100+j).to_s, date_of_birth: '2001.02.03', main_location_id: j)
  end
end

Admin::Authority::RoleType.delete_all
Admin::Authority::RoleType.create(id: 0, name: "authorization")
Admin::Authority::RoleType.create(id: 1, name: "crud own content")
Admin::Authority::RoleType.create(id: 2, name: "crud other's content")

Admin::Authority::Action.delete_all
Admin::Authority::Action.create(id: 0, role_type_id: 1, name: "create", description: nil)
Admin::Authority::Action.create(id: 1, role_type_id: 1, name: "edit", description: nil)
Admin::Authority::Action.create(id: 2, role_type_id: 1, name: "publish", description: nil)
Admin::Authority::Action.create(id: 3, role_type_id: 1, name: "update", description: nil)
Admin::Authority::Action.create(id: 4, role_type_id: 1, name: "delete", description: nil)

Admin::Authority::Action.create(id: 10, role_type_id: 2, name: "create", description: nil)
Admin::Authority::Action.create(id: 11, role_type_id: 2, name: "edit", description: nil)
Admin::Authority::Action.create(id: 12, role_type_id: 2, name: "publish", description: nil)
Admin::Authority::Action.create(id: 13, role_type_id: 2, name: "update", description: nil)
Admin::Authority::Action.create(id: 14, role_type_id: 2, name: "delete", description: nil)
Admin::Authority::Action.create(id: 15, role_type_id: 2, name: "comment", description: nil)
Admin::Authority::Action.create(id: 16, role_type_id: 2, name: "read", description: nil)
Admin::Authority::Action.create(id: 17, role_type_id: 2, name: "restricted_read", description: nil)

Admin::Authority::Role.delete_all
Admin::Authority::Role.create(id: 0, role_type_id: 0, name: "superadmin", description: "can give admin and superadmin rights")
Admin::Authority::Role.create(id: 1, role_type_id: 0, name: "admin", description: "can crud admin tables")
Admin::Authority::Role.create(id: 2, role_type_id: 0, name: "admin for url", description: "can crud url access authorities")
Admin::Authority::Role.create(id: 3, role_type_id: 0, name: "admin for users", description: "can give crud rights to users")
Admin::Authority::Role.create(id: 4, role_type_id: 0, name: "content owner", description: "can give crud rights on own content")

Admin::Authority::Role.create(id: 10, role_type_id: 1, name: "full author", description: "can do anything with own content")
Admin::Authority::Role.create(id: 11, role_type_id: 1, name: "author without delete right", description: "cannot delete own content after publishing")
Admin::Authority::Role.create(id: 12, role_type_id: 1, name: "author without update and delete rights", description: "cannot delete or update own content after publishing")
Admin::Authority::Role.create(id: 13, role_type_id: 1, name: "author with only create right", description: "can only create content")

Admin::Authority::Role.create(id: 20, role_type_id: 2, name: "editor", description: "can edit other's content")
Admin::Authority::Role.create(id: 21, role_type_id: 2, name: "publisher", description: "can publish other's content")
Admin::Authority::Role.create(id: 22, role_type_id: 2, name: "moderator", description: "can moderate other's content")
Admin::Authority::Role.create(id: 23, role_type_id: 2, name: "active reader", description: "can read and act on content")
Admin::Authority::Role.create(id: 24, role_type_id: 2, name: "passive reader", description: "can read but cannot do any action on content")
Admin::Authority::Role.create(id: 25, role_type_id: 2, name: "restricted reader", description: "can see only restricted content")
Admin::Authority::Role.create(id: 26, role_type_id: 2, name: "forbidden reader", description: "cannot see content")
Admin::Authority::Role.create(id: 27, role_type_id: 2, name: "author of other's content", description: "can create other's content")

Admin::Authority::RoleAuthority.delete_all
Admin::Authority::RoleAuthority.create(id: 0, role_id: 0, action: nil, allowed_to_give_authorities: "[0, 1 ]" , condition: "true", name: nil, description: nil)#superadmin
Admin::Authority::RoleAuthority.create(id: 1, role_id: 1, action: nil, allowed_to_give_authorities: "(2..27)", condition: "true", name: nil, description: nil)#admin
Admin::Authority::RoleAuthority.create(id: 2, role_id: 2, action: nil, allowed_to_give_authorities: "(10..27)", condition: "current_user == author", name: nil, description: nil)#content_owner

Admin::Authority::RoleAuthority.create(id: 10, role_id: 10, action: "[0, 1, 2, 3, 4]")
Admin::Authority::RoleAuthority.create(id: 11, role_id: 11, action: "[0, 1, 2, 3   ]")
Admin::Authority::RoleAuthority.create(id: 12, role_id: 12, action: "[0, 1, 2      ]")
Admin::Authority::RoleAuthority.create(id: 13, role_id: 13, action: "[0, 1         ]")

Admin::Authority::RoleAuthority.create(id: 20, role_id: 20, action: "[10           ]")
Admin::Authority::RoleAuthority.create(id: 21, role_id: 21, action: "[12, 14       ]")
Admin::Authority::RoleAuthority.create(id: 22, role_id: 22, action: "[13, 14       ]")
Admin::Authority::RoleAuthority.create(id: 23, role_id: 23, action: "[16, 15       ]")
Admin::Authority::RoleAuthority.create(id: 24, role_id: 24, action: "[16           ]")
Admin::Authority::RoleAuthority.create(id: 25, role_id: 25, action: "[17           ]")
Admin::Authority::RoleAuthority.create(id: 26, role_id: 26, action: "[10           ]")

Admin::Authority::UserAuthority.delete_all
Admin::Authority::UserAuthority.create(user_id: 0,   authorize_roles: "[      ]", own_crud_roles: "[         ]", other_crud_roles: "[25      ]") #guest
Admin::Authority::UserAuthority.create(user_id: 1,   authorize_roles: "(0..4)",   own_crud_roles: "[10       ]", other_crud_roles: "(20..23  )") #superadmin
Admin::Authority::UserAuthority.create(user_id: 11,  authorize_roles: "[1     ]", own_crud_roles: "[         ]", other_crud_roles: "[24      ]") #admin crud admin tables
Admin::Authority::UserAuthority.create(user_id: 12,  authorize_roles: "[2     ]", own_crud_roles: "[         ]", other_crud_roles: "[24      ]") #admin can crud url access authorities
Admin::Authority::UserAuthority.create(user_id: 13,  authorize_roles: "[3     ]", own_crud_roles: "[         ]", other_crud_roles: "[24      ]") #admin can give crud rights to users
Admin::Authority::UserAuthority.create(user_id: 14,  authorize_roles: "[4     ]", own_crud_roles: "[         ]", other_crud_roles: "[24      ]") #content owner
Admin::Authority::UserAuthority.create(user_id: 15,  authorize_roles: "[      ]", own_crud_roles: "[10       ]", other_crud_roles: "[        ]") #full author
#Admin::Authority::UserAuthority.create(user_id: 16,  authorize_roles: "[      ]", own_crud_roles: "[11       ]", other_crud_roles: "[        ]") #author without delete
#Admin::Authority::UserAuthority.create(user_id: 17,  authorize_roles: "[      ]", own_crud_roles: "[12       ]", other_crud_roles: "[        ]") #author withou delete and update
Admin::Authority::UserAuthority.create(user_id: 111, authorize_roles: "[      ]", own_crud_roles: "[13       ]", other_crud_roles: "[        ]") #authour with only create
Admin::Authority::UserAuthority.create(user_id: 112, authorize_roles: "[      ]", own_crud_roles: "[         ]", other_crud_roles: "[20      ]") #editor
Admin::Authority::UserAuthority.create(user_id: 113, authorize_roles: "[      ]", own_crud_roles: "[         ]", other_crud_roles: "[21      ]") #publisher
Admin::Authority::UserAuthority.create(user_id: 114, authorize_roles: "[      ]", own_crud_roles: "[         ]", other_crud_roles: "[22      ]") #moderator
Admin::Authority::UserAuthority.create(user_id: 115, authorize_roles: "[      ]", own_crud_roles: "[         ]", other_crud_roles: "[20, 21  ]") #editor and publisher
Admin::Authority::UserAuthority.create(user_id: 211, authorize_roles: "[      ]", own_crud_roles: "[         ]", other_crud_roles: "[23      ]") #active reader
Admin::Authority::UserAuthority.create(user_id: 212, authorize_roles: "[      ]", own_crud_roles: "[         ]", other_crud_roles: "[24      ]") #passive reader
Admin::Authority::UserAuthority.create(user_id: 213, authorize_roles: "[      ]", own_crud_roles: "[         ]", other_crud_roles: "[25      ]") #restricted reader
Admin::Authority::UserAuthority.create(user_id: 214, authorize_roles: "[      ]", own_crud_roles: "[         ]", other_crud_roles: "[26      ]") #forbidden reader
Admin::Authority::UserAuthority.create(user_id: 215, authorize_roles: "[      ]", own_crud_roles: "[         ]", other_crud_roles: "[27      ]") #author of other's content
