using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using CLIPSNET;

namespace ClipsFormsExample
{
  public partial class ClipsFormsExample : Form
  {
        private CLIPSNET.Environment clips = new CLIPSNET.Environment();
        private HashSet<string> currentFacts;
    public ClipsFormsExample()
    {
            InitializeComponent();
            currentFacts = new HashSet<string>();
    }

    protected override void OnLoad(EventArgs e)
    {
      base.OnLoad(e);
    }

    private void HandleResponse()
    {
      //  Вытаскиаваем факт из ЭС
      String evalStr = "(find-fact ((?f ioproxy)) TRUE)";
      FactAddressValue fv = (FactAddressValue)((MultifieldValue)clips.Eval(evalStr))[0];
    
      MultifieldValue damf = (MultifieldValue)fv["messages"];
      MultifieldValue vamf = (MultifieldValue)fv["answers"];

      textBox1.Text += "Новая итерация : " + System.Environment.NewLine;
      for (int i = damf.Count - 1; i >= 0 ; i--)
      {
        LexemeValue da = (LexemeValue)damf[i];
        byte[] bytes = Encoding.Default.GetBytes(da.Value);
        textBox1.Text += Encoding.UTF8.GetString(bytes) + System.Environment.NewLine;
      }
      if (damf.Count == 0)
            {
                textBox1.Text += "Предоставьте больше характеристик." + System.Environment.NewLine;
            }

      if (vamf.Count > 0)
      {
        textBox1.Text += "----------------------------------------------------" + System.Environment.NewLine;
        for (int i = 0; i < damf.Count; i++)
        {

          LexemeValue va = (LexemeValue)vamf[i];
          textBox1.Text += va.Value + System.Environment.NewLine;
        }
      }

      clips.Eval("(assert (clearmessage))");
    }

    private void nextBtn_Click(object sender, EventArgs e)
    {
      clips.Run();
      HandleResponse();
    }

    private void resetBtn_Click(object sender, EventArgs e)
    {
        textBox1.Text = "Выполнены команды Clear и Reset." + System.Environment.NewLine;
        currentFacts.Clear();
        
        //  Здесь сохранение в файл, и потом инициализация через него
        clips.Clear();
      
        /*string stroka = codeBox.Text;
        System.IO.File.WriteAllText("tmp.clp", codeBox.Text);
        clips.Load("tmp.clp");*/

        //  Так тоже можно - без промежуточного вывода в файл
        clips.LoadFromString(codeBox.Text);

        clips.Reset();
    }

    private void openFile_Click(object sender, EventArgs e)
    {
      if(clipsOpenFileDialog.ShowDialog() == DialogResult.OK)
      {
        codeBox.Text = System.IO.File.ReadAllText(clipsOpenFileDialog.FileName);
        Text = "Экспертная система \"Auto\" – " + clipsOpenFileDialog.FileName;
      }
    }

    private void fontSelect_Click(object sender, EventArgs e)
    {
      if(fontDialog1.ShowDialog() == DialogResult.OK)
      {
        codeBox.Font = fontDialog1.Font;
        textBox1.Font = fontDialog1.Font;
      }
    }

    private void saveAsButton_Click(object sender, EventArgs e)
    {
      clipsSaveFileDialog.FileName = clipsOpenFileDialog.FileName;
      if (clipsSaveFileDialog.ShowDialog() == DialogResult.OK)
      {
        System.IO.File.WriteAllText(clipsSaveFileDialog.FileName, codeBox.Text);
      }
    }

        private void Button1_Click_1(object sender, EventArgs e)
        {
            int currentIndex = this.listBox1.SelectedIndex;
            if (currentIndex != -1)
            {
                string currentFact = this.listBox1.Items[currentIndex].ToString();
                currentFacts.Add(currentFact);                
                textBox1.Text += $"Текущие факты: {string.Join(", ", currentFacts)}" + System.Environment.NewLine;
                string mess = String.Format("(assert({0}))", currentFact);
                clips.Eval(mess);
            }
        }

        private void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void Panel4_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}

// 4 	(slot reaction)
// 5 	(slot restore) 
