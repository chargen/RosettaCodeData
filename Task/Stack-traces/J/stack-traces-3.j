   f=:g
   g=:13!:13 bind ''
   f 7    NB. empty stack trace because debugging has not been enabled
   13!:0]1
   f 7
┌─┬─┬─┬─┬─────────────┬┬───┬──┬─┐
│g│0│0│3│13!:13@(''"_)││┌─┐│  │ │
│ │ │ │ │             │││7││  │ │
│ │ │ │ │             ││└─┘│  │ │
├─┼─┼─┼─┼─────────────┼┼───┼──┼─┤
│f│0│0│3│g            ││┌─┐│  │ │
│ │ │ │ │             │││7││  │ │
│ │ │ │ │             ││└─┘│  │ │
└─┴─┴─┴─┴─────────────┴┴───┴──┴─┘
