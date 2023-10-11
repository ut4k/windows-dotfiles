// -----------------------------------------------------------------------------
// 昇順で並べ替え
//
// Copyright (c) Kuro. All Rights Reserved.
// www:    https://www.haijin-boys.com/
// -----------------------------------------------------------------------------

if (document.selection.Text == "")
  document.selection.SelectAll();
document.selection.Text = document.selection.Text.split("\n").sort().join("\n");
document.selection.StartOfDocument();