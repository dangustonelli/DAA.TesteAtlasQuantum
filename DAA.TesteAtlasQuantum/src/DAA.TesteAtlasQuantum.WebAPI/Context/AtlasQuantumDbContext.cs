using DAA.TesteAtlasQuantum.WebAPI.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DAA.TesteAtlasQuantum.WebAPI.Context
{
    public class AtlasQuantumDbContext : DbContext
    {
        public AtlasQuantumDbContext(DbContextOptions options) : base(options)
        {

        }

        public DbSet<Transacao> Transacoes { get; set; }
    }
}
