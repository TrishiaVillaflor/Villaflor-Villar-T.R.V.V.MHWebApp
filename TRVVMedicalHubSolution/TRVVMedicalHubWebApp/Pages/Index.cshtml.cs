using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Dapper;
using System;
using System.Data.SqlClient;
using System.ComponentModel.DataAnnotations;
using System.Data;
#nullable  disable

namespace TRVVMedicalHubWebApp.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        private readonly IConfiguration _config;

        public IndexModel(ILogger<IndexModel> logger,
            IConfiguration config)
        {
            _logger = logger;
            _config = config;

            using var conn = new SqlConnection(_config.GetConnectionString("TRVV"));
            PatientsList = conn.Query<PatientsModel>("[dbo].[TRVVSearh]",
                new { },
                commandType: CommandType.StoredProcedure);
        }

        public IEnumerable<PatientsModel> PatientsList { get; set; }

        [BindProperty]
        public PatientsModel Patients { get; set; }

        [BindProperty]
        public SearchModel Search { get; set; }

        public class PatientsModel
        {
            public PatientsModel()
            {
                PatientsId = Guid.NewGuid().ToString();
            }

            public string PatientsId { get; set; }
            public string PatientsName { get; set; }
            public string PatientsAddress { get; set; }
            public string PatientsPhone { get; set; }
            public string PatientsDepartment { get; set; }
            public string PatientsIllness { get; set; }
            public string PatientsMedication { get; set; }
            public string PatientsGuardian { get; set; }
        }

        public class SearchModel
        {
            public string Keyword { get; set; }
        }

        public void OnGet()
        {
            Patients = new();
            Search = new();
        }

        public IActionResult OnPostSearchPatients()
        {
            if (ModelState.IsValid)
            {
                var parameters = new DynamicParameters();
                parameters.Add("@Keyword", Search.Keyword, DbType.String, ParameterDirection.Input);

                using var conn = new SqlConnection(_config.GetConnectionString("TRVV"));
                PatientsList = conn.Query<PatientsModel>("[dbo].[FindPatientsByKeyword]",
                    parameters,
                    commandType: CommandType.StoredProcedure);
            }

            return Page();
        }

        public IActionResult OnPostCreatePatients()
        {
            if (ModelState.IsValid)
            {
                var parameters = new DynamicParameters();
                parameters.Add("@Id", Patients.PatientsId, DbType.String, ParameterDirection.Input);
                parameters.Add("@Name", Patients.PatientsName, DbType.String, ParameterDirection.Input);
                parameters.Add("@Address", Patients.PatientsAddress, DbType.String, ParameterDirection.Input);
                parameters.Add("@Phone", Patients.PatientsPhone, DbType.String, ParameterDirection.Input);
                parameters.Add("@Department", Patients.PatientsDepartment, DbType.String, ParameterDirection.Input);
                parameters.Add("Illness", Patients.PatientsIllness, DbType.String, ParameterDirection.Input);
                parameters.Add("@Medication", Patients.PatientsMedication, DbType.String, ParameterDirection.Input);
                parameters.Add("@Guardian", Patients.PatientsGuardian, DbType.String, ParameterDirection.Input);
                using var conn = new SqlConnection(_config.GetConnectionString("TRVV"));
                conn.Execute("[dbo].[TRVVAdd]",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                PatientsList = conn.Query<PatientsModel>("[dbo].[TRVVSearh]",
                    new { },
                    commandType: CommandType.StoredProcedure);
            }

            return Page();
        }

        public IActionResult OnPostDeletePatients(string id = null)
        {
            if (ModelState.IsValid)
            {
                var parameters = new DynamicParameters();
                parameters.Add("@Id", id, DbType.String, ParameterDirection.Input);

                using var conn = new SqlConnection(_config.GetConnectionString("TRVV"));
                conn.Execute("[dbo].[TRVVDelete]", parameters, commandType: CommandType.StoredProcedure);

                PatientsList = conn.Query<PatientsModel>("[dbo].[TRVVSearh]", new { }, commandType: CommandType.StoredProcedure);
            }

            return Page();
        }

        public IActionResult OnPostEditPatients(string id = null)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@Id", id, DbType.String, ParameterDirection.Input);

            using var conn = new SqlConnection(_config.GetConnectionString("TRVV"));
            var results = conn.Query<PatientsModel>("[dbo].[TRVVSearchById]", parameters, commandType: CommandType.StoredProcedure);
            Patients = results.FirstOrDefault();

            return Page();
        }

        public IActionResult OnPostUpdatePatients()
        {
            if (ModelState.IsValid)
            {
                var parameters = new DynamicParameters();
                parameters.Add("@Id", Patients.PatientsId, DbType.String, ParameterDirection.Input);
                parameters.Add("@Name", Patients.PatientsName, DbType.String, ParameterDirection.Input);
                parameters.Add("@Address", Patients.PatientsAddress, DbType.String, ParameterDirection.Input);
                parameters.Add("@Phone", Patients.PatientsPhone, DbType.String, ParameterDirection.Input);
                parameters.Add("@Department", Patients.PatientsDepartment, DbType.String, ParameterDirection.Input);
                parameters.Add("@Illness", Patients.PatientsIllness, DbType.String, ParameterDirection.Input);
                parameters.Add("@Medication", Patients.PatientsMedication, DbType.String, ParameterDirection.Input);
                parameters.Add("@Guardian", Patients.PatientsGuardian, DbType.String, ParameterDirection.Input);
                using var conn = new SqlConnection(_config.GetConnectionString("TRVV"));
                conn.Execute("[dbo].[TRVVUpdate]",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                PatientsList = conn.Query<PatientsModel>("[dbo].[TRVVSearh]",
                    new { },
                    commandType: CommandType.StoredProcedure);
            }

            return Page();
        }

        public IActionResult OnGetNewStudent()
        {
           Patients = new();

            return Page();
        }
    }
}
