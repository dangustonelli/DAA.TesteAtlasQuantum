using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DAA.TesteAtlasQuantum.WebAPI.Models
{
    public class Transacao
    {
        [Key]
        public int ID { get; set; }
        [Required]
        public int IdUsuario { get; set; }
        [Required]
        public int IdContaOrigem { get; set; }
        [Required]
        public int IdContaDestino { get; set; }
        [Required]
        public int IdTipoOperacao { get; set; }
        [Required]
        public decimal Valor { get; set; }
    }
}
