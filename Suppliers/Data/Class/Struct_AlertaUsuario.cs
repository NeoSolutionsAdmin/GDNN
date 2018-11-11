using DotNetNuke.Entities.Users;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data2.Class
{
    public class Struct_AlertaUsuario
    {

        public int Id;
        public string Username;
        public string Name;
        public string LastName;
        public string email;

        public Struct_AlertaUsuario(UserInfo UI)
        {
            Id = UI.UserID;
            Username = UI.Username;
            Name = UI.FirstName;
            LastName = UI.LastName;
            email = UI.Email;
        }


        public static void QuitarUsuario(int iduser)
        {
            Connection.D_AlertaStock.QuitarUsuario(iduser);
        }

        public static List<Struct_AlertaUsuario> GetUsuarios()
        {
            DataTable DT = Connection.D_AlertaStock.RecuperarUsuariosConAlerta();
            if (DT != null)
            {
                List<Struct_AlertaUsuario> UserList = new List<Struct_AlertaUsuario>();
                foreach (DataRow dr in DT.Rows)
                {
                    UserInfo UI = DotNetNuke.Entities.Users.UserController.GetUserById(0, int.Parse(dr["Id_Usuario"].ToString()));
                    if (UI != null)
                    {
                        UserList.Add(new Struct_AlertaUsuario(UI));
                    }
                }
                return UserList;
            }
            else
            {
                return null;
            }
        }
    }

    

}
