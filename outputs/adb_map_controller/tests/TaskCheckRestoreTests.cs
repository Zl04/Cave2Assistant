using System.Reflection;
using System.Windows.Forms;
namespace AdbMapController.Tests;
public sealed class TaskCheckRestoreTests
{
    [Fact]
    public void CreatingListHandlePreservesSavedChecks()
    {
        Exception? error = null;
        var thread = new Thread(() =>
        {
            try
            {
                using var list = new TaskSelectionListView { CheckBoxes = true, View = View.Details };
                list.Columns.Add("任务", 200);
                var restoring = true;
                list.ItemCheck += (_, e) => { if (!restoring && !list.RestoringChecks) e.NewValue = e.CurrentValue; };
                list.Items.Add(new ListViewItem("启用") { Checked = true });
                list.Items.Add(new ListViewItem("禁用") { Checked = false });
                restoring = false;
                _ = list.Handle;
                Assert.True(list.Items[0].Checked);
                Assert.False(list.Items[1].Checked);
                typeof(Control).GetMethod("RecreateHandle", BindingFlags.Instance | BindingFlags.NonPublic)!.Invoke(list, null);
                Assert.True(list.Items[0].Checked);
                Assert.False(list.Items[1].Checked);
                list.Items[0].Checked = false;
                Assert.True(list.Items[0].Checked);
            }
            catch(Exception ex) { error = ex; }
        }) { IsBackground = true };
        thread.SetApartmentState(ApartmentState.STA); thread.Start();
        Assert.True(thread.Join(TimeSpan.FromSeconds(10)), "控件初始化超时");
        if(error is not null) System.Runtime.ExceptionServices.ExceptionDispatchInfo.Capture(error).Throw();
    }
}
