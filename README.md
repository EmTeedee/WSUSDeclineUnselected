# WSUSDeclineUnselected

Script to decline updates for products that are (no longer) selected.

Does what it says on the tin.
I couldn't find an easy way to get a WSUS server to delete updates for old products
(like Windows XP). This checks which products are currently selected and then declines all updates whose product titles don't match the list.

After the updates are decline, the normal WSUS Cleanup should delete them for good and free up disk space.
