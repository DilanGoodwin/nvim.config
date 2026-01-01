return {
  'f-person/git-blame.nvim',
  event = 'VeryLazy',
  opts = {
    enabled = false,
    message_template = ' [Git] <summary> • <author> • <date> ',
    date_format = '%d/%m/%y',
    message_when_not_committed = ' [Git] Not Committed',
    virtual_text_column = 1,
    highlight_group = 'MoreMsg',
  }
}
