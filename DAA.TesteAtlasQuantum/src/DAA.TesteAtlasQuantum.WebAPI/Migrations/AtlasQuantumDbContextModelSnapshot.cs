﻿// <auto-generated />
using DAA.TesteAtlasQuantum.WebAPI.Context;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace DAA.TesteAtlasQuantum.WebAPI.Migrations
{
    [DbContext(typeof(AtlasQuantumDbContext))]
    partial class AtlasQuantumDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "2.2.6-servicing-10079")
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("DAA.TesteAtlasQuantum.WebAPI.Models.Transacao", b =>
                {
                    b.Property<int>("ID")
                        .ValueGeneratedOnAdd()
                        .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

                    b.Property<int>("IDContaDestino");

                    b.Property<int>("IDContaOrigem");

                    b.Property<int>("IDUsuario");

                    b.Property<decimal>("Valor");

                    b.HasKey("ID");

                    b.ToTable("Transacoes");
                });
#pragma warning restore 612, 618
        }
    }
}