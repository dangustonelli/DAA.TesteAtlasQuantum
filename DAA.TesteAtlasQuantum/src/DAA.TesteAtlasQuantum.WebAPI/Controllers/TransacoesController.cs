using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DAA.TesteAtlasQuantum.WebAPI.Context;
using DAA.TesteAtlasQuantum.WebAPI.Models;
using Microsoft.Extensions.Configuration;
using System.Data.SqlClient;
using Dapper;
using System.Data;

namespace DAA.TesteAtlasQuantum.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TransacoesController : ControllerBase
    {
        private readonly AtlasQuantumDbContext _context;
        private IConfiguration _config;

        public TransacoesController(AtlasQuantumDbContext context, IConfiguration configuration)
        {
            _context = context;
            _config = configuration;
        }

        // GET: api/Transacoes
        [HttpGet]
        public IEnumerable<Transacao> GetTransacoes()
        {
            using (SqlConnection conexao = new SqlConnection(_config.GetConnectionString("DefaultConnection")))
            {
                var transacoes = conexao.Query<Transacao>($"SELECT * FROM Transacao WITH(NOLOCK)");
                return transacoes;
            }
        }

        // GET: api/Transacoes/5
        [HttpGet("{id}")]
        public Transacao GetTransacao(int id)
        {
            string sql = $"SELECT * FROM Transacao WITH(NOLOCK) WHERE ID = @id;";

            using (SqlConnection conexao = new SqlConnection(_config.GetConnectionString("DefaultConnection")))
            {
                var transacao = conexao.QueryFirstOrDefault<Transacao>(sql, new { id });
                return transacao;
            }
        }

        // POST: api/Transacoes
        [HttpPost]
        public ActionResult<Transacao> PostTransacao(Transacao transacao)
        {
            try
            {
                string sql = "InserirTransacao";

                using (SqlConnection conexao = new SqlConnection(_config.GetConnectionString("DefaultConnection")))
                {
                    var prcretcode = conexao.Execute(sql, new
                    {
                        transacao.IdUsuario,
                        transacao.IdContaOrigem,
                        transacao.IdContaDestino,
                        transacao.IdTipoOperacao,
                        transacao.Valor
                    }, commandType: CommandType.StoredProcedure);
                }
                return Ok();
            }
            catch
            {
                return BadRequest();
            }
        }
    }
}
